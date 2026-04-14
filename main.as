using namespace B3D;
using namespace CB;

#include "randomitems.as"
#include "015.as"

bool Hook_Initialize() {
    RegisterRandomItem("key1", 20);
    RegisterRandomItem("key2", 16);
    RegisterRandomItem("key3", 12);
    RegisterRandomItem("key4", 8);
    RegisterRandomItem("key5", 4);
    RegisterRandomItem("bat", 20);
    RegisterRandomItem("doc008", 1);
    RegisterRandomItem("doc012", 1);
    RegisterRandomItem("doc035", 1);
    RegisterRandomItem("doc049", 1);
    RegisterRandomItem("doc079", 1);
    RegisterRandomItem("doc096", 1);
    RegisterRandomItem("doc106", 1);
    RegisterRandomItem("doc173", 1);
    RegisterRandomItem("doc372", 1);
    RegisterRandomItem("doc427", 1);
    RegisterRandomItem("doc500", 1);
    RegisterRandomItem("doc513", 1);
    RegisterRandomItem("doc682", 1);
    RegisterRandomItem("doc714", 1);
    RegisterRandomItem("doc860", 1);
    RegisterRandomItem("doc895", 1);
    RegisterRandomItem("doc939", 1);
    RegisterRandomItem("doc966", 1);
    RegisterRandomItem("doc970", 1);
    RegisterRandomItem("doc1048", 1);
    RegisterRandomItem("doc1123", 1);
    RegisterRandomItem("doc1162", 1);
    RegisterRandomItem("doc1499", 1);
    RegisterRandomItem("doc8601", 1);

    Register015Room("kce_015_hall", RoomShape015::TWO_WAY, 100);
    Register015Room("kce_015_fork", RoomShape015::THREE_WAY, 100);

    return false;
}

bool Hook_InitializeEvents() {
    CreateEvent("kce_018cc", "kce_018cc", 0, 1);
    CreateEvent("kce_015cc", "kce_015cc", 0, 1);

    return false;
}

bool Hook_FillRoom(Room@ r) {
    if(r.Template.Name == "kce_018cc") {
        // == Elevator Doors ==
        // Enter
        @r.Doors[0] = Door(r.Zone, r.X - 416 / 256.f, r.Y, r.Z, 270, r, true, 3); r.Doors[0].AutoClose = false; r.Doors[0].Open = true;
        @r.Objects[0] = Pivot::Create();
        r.Objects[0].Position(r.X - 720 / 256.f, r.Y, r.Z, true);
        r.Objects[0].SetParent(r.Object);
        // Exit
        @r.Doors[1] = Door(r.Zone, r.X - 416 / 256.f, r.Y - 4224 / 256.f, r.Z, 270, r, false, 3); r.Doors[1].AutoClose = false; r.Doors[1].Open = false;
        @r.Objects[1] = Pivot::Create();
        r.Objects[1].Position(r.X - 720 / 256.f, r.Y - 4224 / 256.f, r.Z, true);
        r.Objects[1].SetParent(r.Object);
    }
    else if(r.Template.Name == "kce_015cc") { Generate015Nightmare(); }

    return false;
}
bool Hook_PostFillRoom(Room@ r) {
    FillRoom_RandomItems(r);

    return false;
}

bool Hook_UpdateEvent(Event@ e) {
    bool playerIsInRoom = (@e.Room == @Player::CurrentRoom);
    if (e.Name == "kce_018cc" && playerIsInRoom) {
        e.State2 = UpdateElevator(e.State2, e.Room.Doors[0], e.Room.Doors[1], e.Room.Objects[0], e.Room.Objects[1], e);
    }
    else if (e.Name == "kce_015cc") {
        if (playerIsInRoom) {
            //e.State2 = UpdateElevator(e.State2, e.Room.Doors[0], e.Room.Doors[1], e.Room.Objects[0], e.Room.Objects[1], e);
        }
    }

    return false;
}