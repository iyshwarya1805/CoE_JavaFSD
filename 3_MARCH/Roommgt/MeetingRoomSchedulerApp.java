package Roommgt;
import java.util.*;

// Enum representing room features
enum RoomFeature {
    PROJECTOR, VIDEO_CONFERENCING, WHITEBOARD, CONFERENCE_PHONE, AIR_CONDITIONING;
}

// Class representing a meeting room
class MeetingRoom {
    private String roomId;
    private String roomName;
    private int capacity;
    private EnumSet<RoomFeature> features;
    private boolean isBooked;

    public MeetingRoom(String roomId, String roomName, int capacity, EnumSet<RoomFeature> features) {
        this.roomId = roomId;
        this.roomName = roomName;
        this.capacity = capacity;
        this.features = features;
        this.isBooked = false;
    }

    public String getRoomId() {
        return roomId;
    }

    public String getRoomName() {
        return roomName;
    }

    public EnumSet<RoomFeature> getFeatures() {
        return features;
    }
    
    public boolean isBooked() {
        return isBooked;
    }
    
    public void setBooked(boolean booked) {
        isBooked = booked;
    }

    @Override
    public String toString() {
        return roomName;
    }
}

// Class for managing meeting room bookings
class RoomScheduler {
    private Map<String, MeetingRoom> rooms;

    public RoomScheduler() {
        rooms = new HashMap<>();
    }

    // Method to add a meeting room
    public void addMeetingRoom(MeetingRoom room) {
        rooms.put(room.getRoomId(), room);
        System.out.println("Room added: " + room.getRoomName() + ", ID: " + room.getRoomId());
    }

    // Method to book a meeting room based on required features
    public void bookRoom(String roomId, EnumSet<RoomFeature> requiredFeatures) {
        MeetingRoom room = rooms.get(roomId);
        if (room != null && room.getFeatures().containsAll(requiredFeatures) && !room.isBooked()) {
            room.setBooked(true);
            System.out.println("Room " + roomId + " booked successfully.");
        } else if (room != null && room.isBooked()) {
            System.out.println("Room " + roomId + " is already booked.");
        } else {
            System.out.println("Room " + roomId + " does not meet the required features.");
        }
    }

    // Method to cancel a booking
    public void cancelBooking(String roomId) {
        MeetingRoom room = rooms.get(roomId);
        if (room != null && room.isBooked()) {
            room.setBooked(false);
            System.out.println("Booking for room " + roomId + " has been canceled.");
        } else {
            System.out.println("Room " + roomId + " is not currently booked.");
        }
    }

    // Method to list available rooms based on required features
    public void listAvailableRooms(EnumSet<RoomFeature> requiredFeatures) {
        List<String> availableRooms = new ArrayList<>();
        for (MeetingRoom room : rooms.values()) {
            if (!room.isBooked() && room.getFeatures().containsAll(requiredFeatures)) {
                availableRooms.add(room.getRoomName());
            }
        }
        System.out.println("Available rooms with " + requiredFeatures + ": " + availableRooms);
    }
}

// Main class to test functionality
public class MeetingRoomSchedulerApp {
    public static void main(String[] args) {
        RoomScheduler scheduler = new RoomScheduler();
        
        scheduler.addMeetingRoom(new MeetingRoom("1", "Boardroom", 20, EnumSet.of(RoomFeature.PROJECTOR, RoomFeature.CONFERENCE_PHONE, RoomFeature.AIR_CONDITIONING)));
        scheduler.addMeetingRoom(new MeetingRoom("2", "Strategy Room", 10, EnumSet.of(RoomFeature.WHITEBOARD, RoomFeature.AIR_CONDITIONING)));
        
        scheduler.bookRoom("1", EnumSet.of(RoomFeature.PROJECTOR, RoomFeature.CONFERENCE_PHONE));
        scheduler.listAvailableRooms(EnumSet.of(RoomFeature.AIR_CONDITIONING));
        
        scheduler.cancelBooking("1");
        scheduler.listAvailableRooms(EnumSet.of(RoomFeature.AIR_CONDITIONING));
    }
}
