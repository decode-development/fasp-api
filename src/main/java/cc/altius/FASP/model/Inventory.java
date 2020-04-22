/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cc.altius.FASP.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author akil
 */
public class Inventory extends BaseModel implements Serializable {

    private int inventoryId;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date inventoryDate;
    private SimpleObject region;
    private SimpleObject realmCountryPlanningUnit;
    private SimpleObject planningUnit;
    private double multiplier;
    private Double actualQty;
    private double adjustmentQty;
    private SimpleCodeObject unit;
    private SimpleObject dataSource;
    private int versionId;

    public Inventory() {
    }

    public Inventory(int inventoryId, Date inventoryDate, SimpleObject region, SimpleObject realmCountryPlanningUnit, SimpleObject planningUnit, double multiplier, double adjustmentQty, SimpleCodeObject unit, SimpleObject dataSource, int versionId) {
        this.inventoryId = inventoryId;
        this.inventoryDate = inventoryDate;
        this.region = region;
        this.realmCountryPlanningUnit = realmCountryPlanningUnit;
        this.planningUnit = planningUnit;
        this.multiplier = multiplier;
        this.adjustmentQty = adjustmentQty;
        this.unit = unit;
        this.dataSource = dataSource;
        this.versionId = versionId;
    }

    public int getInventoryId() {
        return inventoryId;
    }

    public void setInventoryId(int inventoryId) {
        this.inventoryId = inventoryId;
    }

    public Date getInventoryDate() {
        return inventoryDate;
    }

    public void setInventoryDate(Date inventoryDate) {
        this.inventoryDate = inventoryDate;
    }

    public SimpleObject getRegion() {
        return region;
    }

    public void setRegion(SimpleObject region) {
        this.region = region;
    }

    public SimpleObject getRealmCountryPlanningUnit() {
        return realmCountryPlanningUnit;
    }

    public void setRealmCountryPlanningUnit(SimpleObject realmCountryPlanningUnit) {
        this.realmCountryPlanningUnit = realmCountryPlanningUnit;
    }

    public SimpleObject getPlanningUnit() {
        return planningUnit;
    }

    public void setPlanningUnit(SimpleObject planningUnit) {
        this.planningUnit = planningUnit;
    }

    public double getMultiplier() {
        return multiplier;
    }

    public void setMultiplier(double multiplier) {
        this.multiplier = multiplier;
    }

    public Double getActualQty() {
        return actualQty;
    }

    public void setActualQty(Double actualQty) {
        this.actualQty = actualQty;
    }

    public double getAdjustmentQty() {
        return adjustmentQty;
    }

    public void setAdjustmentQty(double adjustmentQty) {
        this.adjustmentQty = adjustmentQty;
    }

    public SimpleCodeObject getUnit() {
        return unit;
    }

    public void setUnit(SimpleCodeObject unit) {
        this.unit = unit;
    }

    public SimpleObject getDataSource() {
        return dataSource;
    }

    public void setDataSource(SimpleObject dataSource) {
        this.dataSource = dataSource;
    }

    public int getVersionId() {
        return versionId;
    }

    public void setVersionId(int versionId) {
        this.versionId = versionId;
    }

}
