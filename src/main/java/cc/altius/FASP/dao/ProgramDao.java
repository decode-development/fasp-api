/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cc.altius.FASP.dao;

import cc.altius.FASP.model.CustomUserDetails;
import cc.altius.FASP.model.DTO.ManualTaggingDTO;
import cc.altius.FASP.model.DTO.ManualTaggingOrderDTO;
import cc.altius.FASP.model.DTO.ProgramDTO;
import cc.altius.FASP.model.LoadProgram;
import cc.altius.FASP.model.Program;
import cc.altius.FASP.model.ProgramPlanningUnit;
import cc.altius.FASP.model.SimpleObject;
import java.util.List;

/**
 *
 * @author altius
 */
public interface ProgramDao {

    public List<ProgramDTO> getProgramListForDropdown(CustomUserDetails curUser);

    public int addProgram(Program p, int realmId, CustomUserDetails curUser);

    public int updateProgram(Program p, CustomUserDetails curUser);

    public List<Program> getProgramList(CustomUserDetails curUser, boolean active);

    public List<Program> getProgramListForProgramIds(String[] programIds, CustomUserDetails curUser);

    public List<Program> getProgramList(int realmId, CustomUserDetails curUser);

    public Program getProgramById(int programId, CustomUserDetails curUser);

    public List<ProgramPlanningUnit> getPlanningUnitListForProgramId(int programId, boolean active, CustomUserDetails curUser);

    public List<SimpleObject> getPlanningUnitListForProgramIds(String programIds, CustomUserDetails curUser);

    public int saveProgramPlanningUnit(ProgramPlanningUnit[] programPlanningUnits, CustomUserDetails curUser);

    public List<Program> getProgramListForSync(String lastSyncDate, CustomUserDetails curUser);

    public List<ProgramPlanningUnit> getProgramPlanningUnitListForSync(String lastSyncDate, CustomUserDetails curUser);

    public List<ProgramPlanningUnit> getPlanningUnitListForProgramAndCategoryId(int programId, int productCategory, boolean active, CustomUserDetails curUser);

    public Program getProgramList(int realmId, int programId, int versionId);

    public List<ManualTaggingDTO> getShipmentListForManualTagging(int programId, int planningUnitId);

    public ManualTaggingOrderDTO getOrderDetailsByOrderNoAndPrimeLineNo(int programId, int planningUnitId, String orderNo, int primeLineNo);

    public int linkShipmentWithARTMIS(String orderNo, int primeLineNo, int shipmentId, CustomUserDetails curUser);

    public List<ManualTaggingDTO> getShipmentListForDelinking(int programId, int planningUnitId);

    public void delinkShipment(ManualTaggingOrderDTO erpOrderDTO, CustomUserDetails curUser);

    public List<LoadProgram> getLoadProgram(CustomUserDetails curUser);

    public LoadProgram getLoadProgram(int programId, int page, CustomUserDetails curUser);

    public boolean validateProgramCode(int realmId, int programId, String programCode, CustomUserDetails curUser);
    
    public List<Program> getProgramListForSyncProgram(String programIdsString, CustomUserDetails curUser);

    public List<ProgramPlanningUnit> getProgramPlanningUnitListForSyncProgram(String programIdsString, CustomUserDetails curUser);
}
