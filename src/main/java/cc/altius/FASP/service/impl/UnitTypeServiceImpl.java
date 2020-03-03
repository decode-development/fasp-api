/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cc.altius.FASP.service.impl;

import cc.altius.FASP.dao.UnitTypeDao;
import cc.altius.FASP.model.DTO.PrgUnitTypeDTO;
import cc.altius.FASP.model.UnitType;
import cc.altius.FASP.service.UnitTypeService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author altius
 */
@Service
public class UnitTypeServiceImpl implements UnitTypeService {

    @Autowired
    private UnitTypeDao unitTypeDao;

    @Override
    public int addUnitType(UnitType unitType, int userId) {
        return this.unitTypeDao.addUnitType(unitType, userId);
    }

    @Override
    public List<UnitType> getUnitTypeList(boolean active) {
        return this.unitTypeDao.getUnitTypeList(active);
    }

    @Override
    public int updateUnitType(UnitType unitType, int userId) {
        return this.unitTypeDao.updateUnitType(unitType, userId);
    }

    @Override
    public List<PrgUnitTypeDTO> getUnitTypeListForSync() {
        return this.unitTypeDao.getUnitTypeListForSync();
    }

}
