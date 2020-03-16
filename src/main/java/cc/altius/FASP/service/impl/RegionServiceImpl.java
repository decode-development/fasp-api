/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cc.altius.FASP.service.impl;

import cc.altius.FASP.dao.RegionDao;
import cc.altius.FASP.model.DTO.PrgRegionDTO;
import cc.altius.FASP.model.Region;
import cc.altius.FASP.service.RegionService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author altius
 */
@Service
public class RegionServiceImpl implements RegionService {

    @Autowired
    private RegionDao regionDao;

    @Override
    public int addRegion(Region region, int curUser) {
        return this.regionDao.addRegion(region, curUser);
    }

    @Override
    public int editRegion(Region region, int curUser) {
        return this.regionDao.editRegion(region, curUser);
    }

    @Override
    public List<Region> getRegionList(boolean active) {
        return this.regionDao.getRegionList(active);
    }

    @Override
    public List<PrgRegionDTO> getRegionListForSync(String lastSyncDate,int realmId) {
        return this.regionDao.getRegionListForSync(lastSyncDate,realmId);
    }

}
