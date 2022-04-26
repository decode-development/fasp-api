/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cc.altius.FASP.model.rowMapper;

import cc.altius.FASP.model.Budget;
import cc.altius.FASP.model.Currency;
import cc.altius.FASP.model.FundingSource;
import cc.altius.FASP.model.SimpleCodeObject;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author akil
 */
public class BudgetRowMapper implements RowMapper<Budget> {

    @Override
    public Budget mapRow(ResultSet rs, int rowNum) throws SQLException {
        Budget b = new Budget(rs.getInt("BUDGET_ID"), rs.getString("BUDGET_CODE"), new LabelRowMapper().mapRow(rs, rowNum));
        b.setProgram(new SimpleCodeObject(rs.getInt("PROGRAM_ID"), new LabelRowMapper("PROGRAM_").mapRow(rs, rowNum), rs.getString("PROGRAM_CODE")));
        b.setFundingSource(
                new FundingSource(
                        rs.getInt("FUNDING_SOURCE_ID"),
                        rs.getString("FUNDING_SOURCE_CODE"),
                        new LabelRowMapper("FUNDING_SOURCE_").mapRow(rs, rowNum),
                        new SimpleCodeObject(
                                rs.getInt("REALM_ID"),
                                new LabelRowMapper("REALM_").mapRow(rs, rowNum),
                                rs.getString("REALM_CODE")
                        )
                )
        );
        b.setBudgetAmt(rs.getDouble("BUDGET_AMT"));
        b.setBudgetUsdAmt(rs.getDouble("BUDGET_USD_AMT"));
        b.setUsedUsdAmt(rs.getDouble("USED_USD_AMT"));
        b.setCurrency(new Currency(rs.getInt("CURRENCY_ID"), rs.getString("CURRENCY_CODE"), new LabelRowMapper("CURRENCY_").mapRow(rs, rowNum), rs.getDouble("CONVERSION_RATE_TO_USD")));
        b.setStartDate(rs.getDate("START_DATE"));
        b.setStopDate(rs.getDate("STOP_DATE"));
        b.setNotes(rs.getString("NOTES"));
        b.setBaseModel(new BaseModelRowMapper().mapRow(rs, rowNum));
        return b;
    }

}
