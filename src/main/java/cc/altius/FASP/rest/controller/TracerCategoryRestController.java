/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cc.altius.FASP.rest.controller;

import cc.altius.FASP.model.CustomUserDetails;
import cc.altius.FASP.model.TracerCategory;
import cc.altius.FASP.model.ResponseCode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import cc.altius.FASP.service.TracerCategoryService;

/**
 *
 * @author altius
 */
@RestController
@RequestMapping("/api")
public class TracerCategoryRestController {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    TracerCategoryService tracerCategoryService;

//    @GetMapping(value = "/getTracerCategoryListForSync")
//    public String getTracerCategoryListForSync(@RequestParam String lastSyncDate, int realmId) throws UnsupportedEncodingException {
//        String json;
//        List<PrgTracerCategoryDTO> tracerCategoryList = this.tracerCategoryService.getTracerCategoryListForSync(lastSyncDate, realmId);
//        Gson gson = new Gson();
//        Type typeList = new TypeToken<List>() {
//        }.getType();
//        json = gson.toJson(tracerCategoryList, typeList);
//        return json;
//    }

    @PostMapping(path = "/tracerCategory")
    public ResponseEntity postTracerCategory(@RequestBody TracerCategory tracerCategory, Authentication auth) {
        try {
            CustomUserDetails curUser = (CustomUserDetails) auth.getPrincipal();
            this.tracerCategoryService.addTracerCategory(tracerCategory, curUser);
            return new ResponseEntity(new ResponseCode("static.message.addSuccess"), HttpStatus.OK);
        } catch (AccessDeniedException ae) {
            logger.error("Error while trying to add TracerCategory", ae);
            return new ResponseEntity(new ResponseCode("static.message.addFailed"), HttpStatus.UNAUTHORIZED);
        } catch (Exception e) {
            logger.error("Error while trying to add TracerCategory", e);
            return new ResponseEntity(new ResponseCode("static.message.addFailed"), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PutMapping(path = "/tracerCategory")
    public ResponseEntity putTracerCategory(@RequestBody TracerCategory tracerCategory, Authentication auth) {
        try {
            CustomUserDetails curUser = (CustomUserDetails) auth.getPrincipal();
            this.tracerCategoryService.updateTracerCategory(tracerCategory, curUser);
            return new ResponseEntity(new ResponseCode("static.message.updateSuccess"), HttpStatus.OK);
        } catch (AccessDeniedException ae) {
            logger.error("Error while trying to add TracerCategory", ae);
            return new ResponseEntity(new ResponseCode("static.message.updateFailed"), HttpStatus.UNAUTHORIZED);
        } catch (Exception e) {
            logger.error("Error while trying to add TracerCategory", e);
            return new ResponseEntity(new ResponseCode("static.message.updateFailed"), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/tracerCategory")
    public ResponseEntity getTracerCategory(Authentication auth) {
        try {
            CustomUserDetails curUser = (CustomUserDetails) auth.getPrincipal();
            return new ResponseEntity(this.tracerCategoryService.getTracerCategoryList(false, curUser), HttpStatus.OK);
        } catch (Exception e) {
            logger.error("Error while trying to get TracerCategory list", e);
            return new ResponseEntity(new ResponseCode("static.message.listFailed"), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/tracerCategory/{tracerCategoryId}")
    public ResponseEntity getTracerCategory(@PathVariable("tracerCategoryId") int tracerCategoryId, Authentication auth) {
        try {
            CustomUserDetails curUser = (CustomUserDetails) auth.getPrincipal();
            return new ResponseEntity(this.tracerCategoryService.getTracerCategoryById(tracerCategoryId, curUser), HttpStatus.OK);
        } catch (EmptyResultDataAccessException er) {
            logger.error("Error while trying to get TracerCategory list", er);
            return new ResponseEntity(new ResponseCode("static.message.listFailed"), HttpStatus.NOT_FOUND);
        } catch (AccessDeniedException er) {
            logger.error("Error while trying to get TracerCategory list", er);
            return new ResponseEntity(new ResponseCode("static.message.listFailed"), HttpStatus.UNAUTHORIZED);
        } catch (Exception e) {
            logger.error("Error while trying to get TracerCategory list", e);
            return new ResponseEntity(new ResponseCode("static.message.listFailed"), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    @GetMapping("/tracerCategory/realmId/{realmId}")
    public ResponseEntity getTracerCategoryForRealm(@PathVariable("realmId") int realmId, Authentication auth) {
        try {
            CustomUserDetails curUser = (CustomUserDetails) auth.getPrincipal();
            return new ResponseEntity(this.tracerCategoryService.getTracerCategoryListForRealm(realmId, false, curUser), HttpStatus.OK);
        } catch (EmptyResultDataAccessException er) {
            logger.error("Error while trying to get TracerCategory list", er);
            return new ResponseEntity(new ResponseCode("static.message.listFailed"), HttpStatus.NOT_FOUND);
        } catch (AccessDeniedException er) {
            logger.error("Error while trying to get TracerCategory list", er);
            return new ResponseEntity(new ResponseCode("static.message.listFailed"), HttpStatus.UNAUTHORIZED);
        } catch (Exception e) {
            logger.error("Error while trying to get TracerCategory list", e);
            return new ResponseEntity(new ResponseCode("static.message.listFailed"), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}
