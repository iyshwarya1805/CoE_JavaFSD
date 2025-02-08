package ass2;

import java.io.Serializable;

class Location implements Serializable {
    private int aisle, shelf, bin;

    public Location(int aisle, int shelf, int bin) {
        this.aisle = aisle;
        this.shelf = shelf;
        this.bin = bin;
    }

    @Override
    public String toString() {
        return "Aisle " + aisle + ", Shelf " + shelf + ", Bin " + bin;
    }
}