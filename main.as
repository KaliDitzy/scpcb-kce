using namespace B3D;
using namespace CB;

#include "randomitems.as"
#include "015.as"

void Hook_Initialize() {
    RegisterRandomItem("key1", 10);
    RegisterRandomItem("key2", 8);
    RegisterRandomItem("key3", 6);
    RegisterRandomItem("key4", 4);
    RegisterRandomItem("key5", 2);
    RegisterRandomItem("bat", 10);

    Register015Room("kce_015_hall", RoomShape015::TWO_WAY, 100);
}

void Hook_InitializeEvents() {
    CreateEvent("kce_018cc", "kce_018cc", 0, 1);
    CreateEvent("kce_015cc", "kce_015cc", 0, 1);
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
            e.State += 1;
            if (e.State > 100) { Player::BlinkTimer = 0; }
            if (e.State > 300) {
                Player::Collider.Position(60, 60.7f, 60, true);
                Player::Collider.Reset();
                e.State = 0;
            }
        }
    }

    return false;
}