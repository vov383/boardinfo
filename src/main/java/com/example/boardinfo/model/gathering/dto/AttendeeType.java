package com.example.boardinfo.model.gathering.dto;

public enum AttendeeType {
    WAIT("w"),
    ATTENDING("a"),
    REJECTED("r"),
    LEFT("l"),
    BANNED("b");


    private final String code;

    AttendeeType(String code) {
        this.code = code;
    }

    public String getCode() {
        return code;
    }

    public static AttendeeType fromCode(String code) {
        for (AttendeeType type : AttendeeType.values()) {
            if (type.getCode().equals(code)) {
                return type;
            }
        }
        throw new IllegalArgumentException("Invalid AttendType code: " + code);
    }
}