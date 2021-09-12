/*  
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cc.altius.FASP.dao.impl;

import cc.altius.FASP.dao.LabelDao;
import cc.altius.FASP.dao.EquivalencyUnitDao;
import cc.altius.FASP.model.CustomUserDetails;
import cc.altius.FASP.model.EquivalencyUnit;
import cc.altius.FASP.model.EquivalencyUnitMapping;
import cc.altius.FASP.model.rowMapper.EquivalencyUnitMappingRowMapper;
import cc.altius.FASP.model.rowMapper.EquivalencyUnitRowMapper;
import cc.altius.utils.DateUtils;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author akil
 */
@Repository
public class EquivalencyUnitDaoImpl implements EquivalencyUnitDao {

    private DataSource dataSource;
    private NamedParameterJdbcTemplate namedParameterJdbcTemplate;
    @Autowired
    private LabelDao labelDao;

    @Autowired
    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
        this.namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }

    @Override
    public List<EquivalencyUnit> getEquivalencyUnitList(boolean active, CustomUserDetails curUser) {
        String sqlString = "SELECT  "
                + "    eu.EQUIVALENCY_UNIT_ID,  "
                + "    eu.LABEL_ID, eu.LABEL_EN, eu.LABEL_FR, eu.LABEL_SP, eu.LABEL_PR, "
                + "    eu.ACTIVE, eu.CREATED_DATE, cb.USER_ID `CB_USER_ID`, cb.USERNAME `CB_USERNAME`, eu.`LAST_MODIFIED_DATE`, eu.LAST_MODIFIED_BY, lmb.USER_ID `LMB_USER_ID`, lmb.USERNAME `LMB_USERNAME`, "
                + "    r.REALM_ID, r.LABEL_ID `REALM_LABEL_ID`, r.LABEL_EN `REALM_LABEL_EN`, r.LABEL_FR `REALM_LABEL_FR`, r.LABEL_SP `REALM_LABEL_SP`, r.LABEL_PR `REALM_LABEL_PR`, r.REALM_CODE "
                + "FROM vw_equivalency_unit eu "
                + "LEFT JOIN vw_realm r ON eu.REALM_ID=r.REALM_ID "
                + "LEFT JOIN us_user cb ON cb.USER_ID=eu.CREATED_BY "
                + "LEFT JOIN us_user lmb ON lmb.USER_ID=eu.LAST_MODIFIED_BY ";
        if (active) {
            sqlString += " AND eu.ACTIVE ";
        }
        sqlString += "ORDER BY eu.LABEL_EN";
        Map<String, Object> params = new HashMap<>();
        params.put("realmId", curUser.getRealm().getRealmId());
        return namedParameterJdbcTemplate.query(sqlString, params, new EquivalencyUnitRowMapper());
    }

    @Override
    @Transactional
    public int addAndUpdateEquivalencyUnit(List<EquivalencyUnit> equivalencyUnitList, CustomUserDetails curUser) {
        SimpleJdbcInsert si = new SimpleJdbcInsert(dataSource).withTableName("rm_equivalency_unit");
        Date dt = DateUtils.getCurrentDateObject(DateUtils.EST);
        List<SqlParameterSource> paramList = new LinkedList<>();
        equivalencyUnitList.stream().filter(ut -> ut.getEquivalencyUnitId() == 0).collect(Collectors.toList()).forEach(ut -> {
            MapSqlParameterSource param = new MapSqlParameterSource();
            param.addValue("LABEL_ID", this.labelDao.addLabel(ut.getLabel(), 44, curUser.getUserId()));
            param.addValue("REALM_ID", curUser.getRealm().getRealmId());
            param.addValue("ACTIVE", 1);
            param.addValue("CREATED_BY", curUser.getUserId());
            param.addValue("CREATED_DATE", dt);
            param.addValue("LAST_MODIFIED_BY", curUser.getUserId());
            param.addValue("LAST_MODIFIED_DATE", dt);
            paramList.add(param);
        }
        );
        int rows = 0;
        int[] updatedRows;
        if (paramList.size() > 0) {
            updatedRows = si.executeBatch(paramList.toArray(new MapSqlParameterSource[paramList.size()]));
            rows += Arrays.stream(updatedRows).filter(i -> i == 1).count();
            paramList.clear();
        }
        equivalencyUnitList.stream().filter(ut -> ut.getEquivalencyUnitId() != 0).collect(Collectors.toList()).forEach(ut -> {
            Map<String, Object> param = new HashMap<>();
            param.put("equivalencyUnitId", ut.getEquivalencyUnitId());
            param.put("labelEn", ut.getLabel().getLabel_en());
            param.put("active", ut.isActive());
            param.put("curUser", curUser.getUserId());
            param.put("dt", dt);
            paramList.add(new MapSqlParameterSource(param));
        }
        );
        String sql = "UPDATE rm_equivalency_unit eu "
                + "LEFT JOIN ap_label l ON eu.LABEL_ID=l.LABEL_ID "
                + "SET "
                + "eu.ACTIVE=:active, "
                + "eu.LAST_MODIFIED_DATE=:dt, "
                + "eu.LAST_MODIFIED_BY=:curUser, "
                + "l.LABEL_EN=:labelEn, "
                + "l.LAST_MODIFIED_DATE=:dt, "
                + "l.LAST_MODIFIED_BY=:curUser "
                + "WHERE "
                + "     eu.EQUIVALENCY_UNIT_ID=:equivalencyUnitId AND "
                + "     ( "
                + "         l.LABEL_EN!=:labelEn OR "
                + "         eu.ACTIVE!=:active"
                + "     )";
        if (paramList.size() > 0) {
            updatedRows = namedParameterJdbcTemplate.batchUpdate(sql, paramList.toArray(new MapSqlParameterSource[paramList.size()]));
            rows += Arrays.stream(updatedRows).filter(i -> i > 0).count();
        }
        return rows;
    }

    @Override
    public List<EquivalencyUnitMapping> getEquivalencyUnitMappingList(boolean active, CustomUserDetails curUser) {
        String sqlString = "SELECT  "
                + "    eum.EQUIVALENCY_UNIT_MAPPING_ID, eum.CONVERT_TO_FU, eum.NOTES,  "
                + "    eum.ACTIVE, eum.CREATED_DATE, cb.USER_ID `CB_USER_ID`, cb.USERNAME `CB_USERNAME`, eum.`LAST_MODIFIED_DATE`, eum.LAST_MODIFIED_BY, lmb.USER_ID `LMB_USER_ID`, lmb.USERNAME `LMB_USERNAME`, "
                + "    eu.EQUIVALENCY_UNIT_ID, eu.LABEL_ID, eu.LABEL_EN, eu.LABEL_FR, eu.LABEL_SP, eu.LABEL_PR, "
                + "    eu.ACTIVE `EU_ACTIVE`, eu.CREATED_DATE `EU_CREATED_DATE`, eucb.USER_ID `EU_CB_USER_ID`, eucb.USERNAME `EU_CB_USERNAME`, eu.`LAST_MODIFIED_DATE` `EU_LAST_MODIFIED_DATE`, eu.LAST_MODIFIED_BY `EU_LAST_MODIFIED_BY`, eulmb.USER_ID `EU_LMB_USER_ID`, eulmb.USERNAME `EU_LMB_USERNAME`, "
                + "    r.REALM_ID, r.LABEL_ID `REALM_LABEL_ID`, r.LABEL_EN `REALM_LABEL_EN`, r.LABEL_FR `REALM_LABEL_FR`, r.LABEL_SP `REALM_LABEL_SP`, r.LABEL_PR `REALM_LABEL_PR`, r.REALM_CODE, "
                + "    fu.FORECASTING_UNIT_ID, fu.LABEL_ID `FU_LABEL_ID`, fu.LABEL_EN `FU_LABEL_EN`, fu.LABEL_FR `FU_LABEL_FR`, fu.LABEL_SP `FU_LABEL_SP`, fu.LABEL_PR `FU_LABEL_PR`, "
                + "    u.UNIT_ID, u.LABEL_ID `U_LABEL_ID`, u.LABEL_EN `U_LABEL_EN`, u.LABEL_FR `U_LABEL_FR`, u.LABEL_SP `U_LABEL_SP`, u.LABEL_PR `U_LABEL_PR`, u.UNIT_CODE, "
                + "    tc.TRACER_CATEGORY_ID, tc.LABEL_ID `TC_LABEL_ID`, tc.LABEL_EN `TC_LABEL_EN`, tc.LABEL_FR `TC_LABEL_FR`, tc.LABEL_SP `TC_LABEL_SP`, tc.LABEL_PR `TC_LABEL_PR`, "
                + "    p.PROGRAM_ID, p.LABEL_ID `P_LABEL_ID`, p.LABEL_EN `P_LABEL_EN`, p.LABEL_FR `P_LABEL_FR`, p.LABEL_SP `P_LABEL_SP`, p.LABEL_PR `P_LABEL_PR`, p.PROGRAM_CODE "
                + "FROM rm_equivalency_unit_mapping eum "
                + "LEFT JOIN vw_equivalency_unit eu ON eum.EQUIVALENCY_UNIT_ID=eu.EQUIVALENCY_UNIT_ID "
                + "LEFT JOIN vw_realm r ON eu.REALM_ID=r.REALM_ID "
                + "LEFT JOIN us_user eucb ON eucb.USER_ID=eu.CREATED_BY "
                + "LEFT JOIN us_user eulmb ON eulmb.USER_ID=eu.LAST_MODIFIED_BY "
                + "LEFT JOIN us_user cb ON cb.USER_ID=eum.CREATED_BY "
                + "LEFT JOIN us_user lmb ON lmb.USER_ID=eum.LAST_MODIFIED_BY "
                + "LEFT JOIN vw_forecasting_unit fu ON eum.FORECASTING_UNIT_ID=fu.FORECASTING_UNIT_ID "
                + "LEFT JOIN vw_unit u ON fu.UNIT_ID=u.UNIT_ID "
                + "LEFT JOIN vw_tracer_category tc ON fu.TRACER_CATEGORY_ID=tc.TRACER_CATEGORY_ID "
                + "LEFT JOIN vw_dataset p ON p.PROGRAM_ID=eum.PROGRAM_ID "
                + "WHERE TRUE ";
        if (active) {
            sqlString += " AND eum.ACTIVE ";
        }
        sqlString += "ORDER BY eu.LABEL_EN";
        Map<String, Object> params = new HashMap<>();
        params.put("realmId", curUser.getRealm().getRealmId());
        return namedParameterJdbcTemplate.query(sqlString, params, new EquivalencyUnitMappingRowMapper());
    }

    @Override
    @Transactional
    public int addAndUpdateEquivalencyUnitMapping(List<EquivalencyUnitMapping> equivalencyUnitMappingList, CustomUserDetails curUser) {
        SimpleJdbcInsert si = new SimpleJdbcInsert(dataSource).withTableName("rm_equivalency_unit_mapping");
        Date dt = DateUtils.getCurrentDateObject(DateUtils.EST);
        List<SqlParameterSource> paramList = new LinkedList<>();
        equivalencyUnitMappingList.stream().filter(eum -> eum.getEquivalencyUnitMappingId() == 0).collect(Collectors.toList()).forEach(eum -> {
            MapSqlParameterSource param = new MapSqlParameterSource();
            param.addValue("REALM_ID", curUser.getRealm().getRealmId());
            param.addValue("EQUIVALENCY_UNIT_ID", eum.getEquivalencyUnit().getEquivalencyUnitId());
            param.addValue("FORECASTING_UNIT_ID", eum.getForecastingUnit().getId());
            param.addValue("PROGRAM_ID", (eum.getProgram() == null ? null : (eum.getProgram().getId() == 0 ? null : eum.getProgram().getId())));
            param.addValue("NOTES", eum.getNotes());
            param.addValue("CONVERT_TO_FU", eum.getConvertToFu());
            param.addValue("ACTIVE", 1);
            param.addValue("CREATED_BY", curUser.getUserId());
            param.addValue("CREATED_DATE", dt);
            param.addValue("LAST_MODIFIED_BY", curUser.getUserId());
            param.addValue("LAST_MODIFIED_DATE", dt);
            paramList.add(param);
        }
        );
        int rows = 0;
        int[] updatedRows;
        if (paramList.size() > 0) {
            updatedRows = si.executeBatch(paramList.toArray(new MapSqlParameterSource[paramList.size()]));
            rows += Arrays.stream(updatedRows).filter(i -> i == 1).count();
            paramList.clear();
        }
        equivalencyUnitMappingList.stream().filter(eum -> eum.getEquivalencyUnitMappingId() != 0).collect(Collectors.toList()).forEach(eum -> {
            Map<String, Object> param = new HashMap<>();
            param.put("equivalencyUnitMappingId", eum.getEquivalencyUnitMappingId());
            param.put("active", eum.isActive());
            param.put("notes", eum.getNotes());
            param.put("convertToFu", eum.getConvertToFu());
            param.put("curUser", curUser.getUserId());
            param.put("dt", dt);
            paramList.add(new MapSqlParameterSource(param));
        }
        );
        String sql = "UPDATE rm_equivalency_unit_mapping eum "
                + "SET "
                + "eum.ACTIVE=:active, "
                + "eum.CONVERT_TO_FU=:convertToFu, "
                + "eum.NOTES=:notes, "
                + "eum.LAST_MODIFIED_DATE=:dt, "
                + "eum.LAST_MODIFIED_BY=:curUser "
                + "WHERE "
                + "     eum.EQUIVALENCY_UNIT_MAPPING_ID=:equivalencyUnitMappingId AND "
                + "     ("
                + "         eum.ACTIVE!=:active OR "
                + "         eum.CONVERT_TO_FU!=:convertToFu OR "
                + "         eum.NOTES!=:notes"
                + "     )";
        if (paramList.size() > 0) {
            updatedRows = namedParameterJdbcTemplate.batchUpdate(sql, paramList.toArray(new MapSqlParameterSource[paramList.size()]));
            rows += Arrays.stream(updatedRows).filter(i -> i > 0).count();
        }
        return rows;
    }

}
