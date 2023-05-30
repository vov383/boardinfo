package com.example.boardinfo.handler;

import com.example.boardinfo.model.gathering.dto.AttendeeType;
import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedTypes;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@MappedTypes(AttendeeType.class)
public class AttendeeTypeHandler extends BaseTypeHandler<AttendeeType> {

    @Override
    public void setNonNullParameter(PreparedStatement ps, int i, AttendeeType parameter, JdbcType jdbcType) throws SQLException {
        ps.setString(i, parameter.getCode());
    }

    @Override
    public AttendeeType getNullableResult(ResultSet rs, String columnName) throws SQLException {
        String value = rs.getString(columnName);
        return value != null ? AttendeeType.fromCode(value) : null;
    }

    @Override
    public AttendeeType getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
        return null;
    }

    @Override
    public AttendeeType getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
        return null;
    }
}
