package com.example.boardinfo.model.game.dto.gameRating;

public class RatingStatisticDTO {

    private float value;
    private int count;

    public float getValue() {
        return value;
    }

    public void setValue(float value) {
        this.value = value;
    }


    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    @Override
    public String toString() {
        return "RatingStatisticDTO{" +
                "value=" + value +
                ", count=" + count +
                '}';
    }
}
