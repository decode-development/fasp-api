/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cc.altius.FASP.web.controller;

import cc.altius.FASP.model.CustomUserDetails;
import cc.altius.FASP.model.DTO.PrgManufacturerDTO;
import cc.altius.FASP.model.Manufacturer;
import cc.altius.FASP.model.ResponseFormat;
import cc.altius.FASP.service.ManufacturerService;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Type;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author altius
 */
@RestController
@RequestMapping("/api")
@CrossOrigin(origins = {"http://localhost:4202", "https://faspdeveloper.github.io"})
public class ManufacturerController {

    @Autowired
    ManufacturerService manufacturerService;

    @GetMapping(value = "/getManufacturerListForSync")
    public String getManufacturerListForSync(@RequestParam String lastSyncDate,int realmId) throws UnsupportedEncodingException {
        String json;
        List<PrgManufacturerDTO> manufacturerList = this.manufacturerService.getManufacturerListForSync(lastSyncDate,realmId);
        Gson gson = new Gson();
        Type typeList = new TypeToken<List>() {
        }.getType();
        json = gson.toJson(manufacturerList, typeList);
        return json;
    }
    
    @PostMapping(path = "/manufacturer")
    public ResponseFormat postUnit(@RequestBody Manufacturer manufacturer, Authentication auth) {
        try {
            int curUser = ((CustomUserDetails) auth.getPrincipal()).getUserId();
            int unitId = this.manufacturerService.addManufacturer(manufacturer, curUser);
            return new ResponseFormat("Successfully added manufacturer with Id " + unitId);
        } catch (Exception e) {
            return new ResponseFormat("Failed", e.getMessage());
        }
    }

    @PutMapping(path = "/manufacturer")
    public ResponseFormat putHealhArea(@RequestBody Manufacturer manufacturer, Authentication auth) {
        try {
            int curUser = ((CustomUserDetails) auth.getPrincipal()).getUserId();
            int rows = this.manufacturerService.updateManufacturer(manufacturer, curUser);
            return new ResponseFormat("Successfully updated manufacturer");
        } catch (Exception e) {
            return new ResponseFormat("Failed", e.getMessage());
        }
    }

    @GetMapping("/manufacturer")
    public ResponseFormat getUnit() {
        try {
            return new ResponseFormat("Success", "", this.manufacturerService.getManufacturerList());
        } catch (Exception e) {
            return new ResponseFormat("Failed", e.getMessage());
        }
    }

    @GetMapping("/manufacturer/{manufacturerId}")
    public ResponseFormat getUnit(@PathVariable("manufacturerId") int manufacturerId) {
        try {
            return new ResponseFormat("Success", "", this.manufacturerService.getManufacturerById(manufacturerId));
        } catch (Exception e) {
            return new ResponseFormat("Failed", e.getMessage());
        }
    }

}
