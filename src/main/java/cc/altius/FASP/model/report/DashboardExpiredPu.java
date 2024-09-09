/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cc.altius.FASP.model.report;

import cc.altius.FASP.framework.JsonDateDeserializer;
import cc.altius.FASP.framework.JsonDateSerializer;
import cc.altius.FASP.model.SimpleObject;
import cc.altius.FASP.model.Views;
import com.fasterxml.jackson.annotation.JsonView;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author akil
 */
public class DashboardExpiredPu implements Serializable {

    @JsonView(Views.ReportView.class)
    private SimpleObject planningUnit;
    @JsonView(Views.ReportView.class)
    @JsonDeserialize(using = JsonDateDeserializer.class)
    @JsonSerialize(using = JsonDateSerializer.class)
    private Date expDate;
    @JsonView(Views.ReportView.class)
    private int batchId;
    @JsonView(Views.ReportView.class)
    private String batchNo;
    @JsonView(Views.ReportView.class)
    private boolean autoGenerated;
    @JsonView(Views.ReportView.class)
    private int expiringQty;
    @JsonView(Views.ReportView.class)
    private double price;

    public DashboardExpiredPu() {
    }

    public DashboardExpiredPu(SimpleObject planningUnit, Date expDate, int batchId, String batchNo, boolean autoGenerated, int expiringQty, double price) {
        this.planningUnit = planningUnit;
        this.expDate = expDate;
        this.batchId = batchId;
        this.batchNo = batchNo;
        this.autoGenerated = autoGenerated;
        this.expiringQty = expiringQty;
        this.price = price;
    }

    public SimpleObject getPlanningUnit() {
        return planningUnit;
    }

    public void setPlanningUnit(SimpleObject planningUnit) {
        this.planningUnit = planningUnit;
    }

    public Date getExpDate() {
        return expDate;
    }

    public void setExpDate(Date expDate) {
        this.expDate = expDate;
    }

    public int getBatchId() {
        return batchId;
    }

    public void setBatchId(int batchId) {
        this.batchId = batchId;
    }

    public String getBatchNo() {
        return batchNo;
    }

    public void setBatchNo(String batchNo) {
        this.batchNo = batchNo;
    }

    public boolean isAutoGenerated() {
        return autoGenerated;
    }

    public void setAutoGenerated(boolean autoGenerated) {
        this.autoGenerated = autoGenerated;
    }

    public int getExpiringQty() {
        return expiringQty;
    }

    public void setExpiringQty(int expiringQty) {
        this.expiringQty = expiringQty;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    @JsonView(Views.ReportView.class)
    public double getExpiryAmt() {
        return (double) this.expiringQty * this.price;
    }

}
