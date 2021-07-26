/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cc.altius.FASP.service.impl;

import cc.altius.FASP.dao.OrganisationDao;
import cc.altius.FASP.dao.RealmCountryDao;
import cc.altius.FASP.dao.RealmDao;

import cc.altius.FASP.model.CustomUserDetails;
import cc.altius.FASP.model.Organisation;
import cc.altius.FASP.model.Realm;
import cc.altius.FASP.model.RealmCountry;
import cc.altius.FASP.service.AclService;
import cc.altius.FASP.service.OrganisationService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;

/**
 *
 * @author altius
 */
@Service
public class OrganisationServiceImpl implements OrganisationService {

    @Autowired
    private OrganisationDao organisationDao;
    @Autowired
    private RealmCountryDao realmCountryDao;
    @Autowired
    private RealmDao realmDao;
    @Autowired
    private AclService aclService;

    @Override
    public int addOrganisation(Organisation organisation, CustomUserDetails curUser) {
        if (this.aclService.checkRealmAccessForUser(curUser, organisation.getRealm().getId())) {
            System.out.println("ORGANISATION-SERVICE->>>>>>>>>>>>>>>>>>>>>"+organisation);
            return organisationDao.addOrganisation(organisation, curUser);
        } else {
            throw new AccessDeniedException("Access denied");
        }
    }

    @Override
    public int updateOrganisation(Organisation organisation, CustomUserDetails curUser) {
        Organisation o = this.getOrganisationById(organisation.getOrganisationId(), curUser);
        if (this.aclService.checkRealmAccessForUser(curUser, o.getRealm().getId())) {
            return organisationDao.updateOrganisation(organisation, curUser);
        } else {
            throw new AccessDeniedException("Access denied");
        }
    }

    @Override
    public List<Organisation> getOrganisationList(CustomUserDetails curUser) {
        return organisationDao.getOrganisationList(curUser);
    }

    @Override
    public List<Organisation> getOrganisationListByRealmCountry(int realmCountryId, CustomUserDetails curUser) {
        RealmCountry rc = this.realmCountryDao.getRealmCountryById(realmCountryId, curUser);
        if (rc == null) {
            throw new EmptyResultDataAccessException(1);
        }
        return this.organisationDao.getOrganisationListByRealmCountry(realmCountryId, curUser);
    }

    @Override
    public List<Organisation> getOrganisationListByRealmId(int realmId, CustomUserDetails curUser) {
        Realm r = this.realmDao.getRealmById(realmId, curUser);
        if (r == null) {
            throw new EmptyResultDataAccessException(1);
        }
        if (this.aclService.checkRealmAccessForUser(curUser, realmId)) {
            return this.organisationDao.getOrganisationListByRealmId(realmId, curUser);
        } else {
            throw new AccessDeniedException("Access denied");
        }
    }

    @Override
    public Organisation getOrganisationById(int organisationId, CustomUserDetails curUser) {
        Organisation org = organisationDao.getOrganisationById(organisationId, curUser);
        if (org != null) {
            return org;
        } else {
            throw new EmptyResultDataAccessException(1);
        }
    }

    @Override
    public String getDisplayName(int realmId, String name, CustomUserDetails curUser) {
        return this.organisationDao.getDisplayName(realmId, name, curUser);
    }

    @Override
    public List<Organisation> getOrganisationListForSync(String lastSyncDate, CustomUserDetails curUser) {
        return this.organisationDao.getOrganisationListForSync(lastSyncDate, curUser);
    }

}
