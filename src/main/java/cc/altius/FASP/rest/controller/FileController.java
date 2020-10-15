/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cc.altius.FASP.rest.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author akil
 */
@RestController
public class FileController {

    @Value("${qat.filePath}")
    private String QAT_FILE_PATH;
    @Value("${qat.additionalFiles.path}")
    private String QAT_ADDITIONAL_FILES;
    @Value("${qat.quantimedFileName.Linux}")
    private String QUANTIMED_LINUX;
    @Value("${qat.quantimedFileName.Windows}")
    private String QUANTIMED_WINDOWS;
    @Value("${qat.userGuideFileName}")
    private String QAT_USER_GUIDE;

    @GetMapping("/file/{fileName}")
    public byte[] getFile(@PathVariable("fileName") String fileName, HttpServletResponse response, Authentication auth) throws FileNotFoundException, IOException {
        FileInputStream fin = null;
        switch (fileName) {
            case "qatUserGuide":
                response.setContentType("application/octet-stream");
                response.setHeader("Content-Disposition", "attachment;filename=" + QAT_USER_GUIDE);
                response.setStatus(HttpServletResponse.SC_OK);
                fin = new FileInputStream(new File(QAT_FILE_PATH + QAT_ADDITIONAL_FILES + QAT_USER_GUIDE));
                break;
            case "quantimedLinux":
                response.setContentType("application/octet-stream");
                response.setHeader("Content-Disposition", "attachment;filename=" + QUANTIMED_LINUX);
                response.setStatus(HttpServletResponse.SC_OK);
                fin = new FileInputStream(new File(QAT_FILE_PATH + QAT_ADDITIONAL_FILES + QUANTIMED_LINUX));
                break;
            case "quantimedWindows":
                response.setContentType("application/pdf");
                response.setHeader("Content-Disposition", "attachment;filename=" + QUANTIMED_WINDOWS);
                response.setStatus(HttpServletResponse.SC_OK);
                fin = new FileInputStream(new File(QAT_FILE_PATH + QAT_ADDITIONAL_FILES + QUANTIMED_WINDOWS));
                break;
        }
        return IOUtils.toByteArray(fin);
    }

}
