/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cc.altius.FASP.rest.controller;

import cc.altius.FASP.service.SubFundingSourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author altius
 */
@RestController
public class SubFundingSourceController {
    
    @Autowired
    private SubFundingSourceService subFundingSourceService;
    
    
    
}
