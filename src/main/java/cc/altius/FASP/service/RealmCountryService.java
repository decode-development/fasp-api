/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cc.altius.FASP.service;

import cc.altius.FASP.model.CustomUserDetails;
import cc.altius.FASP.model.RealmCountry;
import java.util.List;

/**
 *
 * @author altius
 */
public interface RealmCountryService {

    public int addRealmCountry(List<RealmCountry> realmCountryList, CustomUserDetails curUser);

    public int updateRealmCountry(List<RealmCountry> realmCountryList, CustomUserDetails curUser);

    public List<RealmCountry> getRealmCountryList(CustomUserDetails curUser);

    public RealmCountry getRealmCountryById(int realmCountryId, CustomUserDetails curUser);
    
    public List<RealmCountry> getRealmCountryListByRealmId(int realmId, CustomUserDetails curUser);
    
}
