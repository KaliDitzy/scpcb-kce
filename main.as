#include "randomitems.as"

using namespace B3D;
using namespace CB;

void Hook_InitializeEvents() {
    CreateEvent("kce_018cc", "kce_018cc", 0, 1);
}

void Hook_FillRoom(Room@ r) {
    if (r.Template.Name == "kce_018cc") {
        // == Elevator Doors ==
        // Enter
        @r.Doors[0] = Door(r.Zone, r.X - 416 / 256.f, r.Y, r.Z, 270, r, true, 3); r.Doors[0].AutoClose = false; r.Doors[0].Open = true;
        @r.Objects[0] = Pivot::Create();
        r.Objects[0].Position(r.X - 720 / 256.f, r.Y, r.Z, 1);
        r.Objects[0].SetParent(r.Object);
        // Exit
        @r.Doors[1] = Door(r.Zone, r.X - 416 / 256.f, r.Y - 4224 / 256.f, r.Z, 270, r, false, 3); r.Doors[1].AutoClose = false; r.Doors[1].Open = false;
        @r.Objects[1] = Pivot::Create();
        r.Objects[1].Position(r.X - 720 / 256.f, r.Y - 4224 / 256.f, r.Z, 1);
        r.Objects[1].SetParent(r.Object);
    }
    FillRoom_RandomItems(r);
}

void Hook_UpdateEvent(Event@ e) {
    if (e.Name == "kce_018cc") {
        e.State2 = UpdateElevator(e.State2, e.Room.Doors[0], e.Room.Doors[1], e.Room.Objects[0], e.Room.Objects[1], e);
    }
}