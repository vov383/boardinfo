package com.example.boardinfo.model.game.dto.designer;

public class DesignerDTO {
    private int dnum;
    private String designer;

    public DesignerDTO() {}

    public DesignerDTO(int dnum, String designer) {
        this.dnum = dnum;
        this.designer = designer;
    }

    public int getDnum() {
        return dnum;
    }

    public void setDnum(int dnum) {
        this.dnum = dnum;
    }

    public String getDesigner() {
        return designer;
    }

    public void setDesigner(String designer) {
        this.designer = designer;
    }

    @Override
    public String toString() {
        return "DesignerDTO{" +
                "dnum=" + dnum +
                ", designer='" + designer + '\'' +
                '}';
    }
}
