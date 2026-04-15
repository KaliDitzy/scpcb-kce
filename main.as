using namespace B3D;
using namespace CB;

#include "triggers.as"
#include "randomitems.as"
#include "015.as"

bool playerInside015 = false;

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
    else if(r.Template.Name == "kce_015cc") {
        // == Elevator Doors ==
        // Enter
        @r.Doors[0] = Door(r.Zone, r.X - 416 / 256.f, r.Y, r.Z + 720 / 256.f, 270, r, true, 3); r.Doors[0].AutoClose = false; r.Doors[0].Open = true;
        @r.Objects[0] = Pivot::Create();
        r.Objects[0].Position(r.X - 720 / 256.f, r.Y, r.Z + 720 / 256.f, true);
        r.Objects[0].SetParent(r.Object);
        // Exit
        @r.Doors[1] = Door(r.Zone, r.X - 416 / 256.f, r.Y - 4096 / 256.f, r.Z + 720 / 256.f, 270, r, false, 3); r.Doors[1].AutoClose = false; r.Doors[1].Open = false;
        @r.Objects[1] = Pivot::Create();
        r.Objects[1].Position(r.X - 720 / 256.f, r.Y - 4096 / 256.f, r.Z + 720 / 256.f, true);
        r.Objects[1].SetParent(r.Object);

        //Triggers
        //RegisterTrigger("enter015", r.Template.Name, r.X + 128 / 256.f, r.Y - 4096 / 256.f, r.Z + 448 / 256.f, r.X + 384 / 256.f, r.Y - 3584 / 256.f, r.Z + 960 / 256.f);

        Generate015Nightmare();
    }

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
        const string deathMsg = "A severely mutilated D-Class was discovered within SCP-015, the subject appeared thin likely from extended malnourishment prior to their expiration.\nSCP-015 grew plumbing through, in, and around the subject's body, rendering it unrecognizable at first glance, though DNA testing later revealed the identity of the corpse as belonging to D-9341.";
        if (playerIsInRoom && !playerInside015) {
            e.State2 = UpdateElevator(e.State2, e.Room.Doors[0], e.Room.Doors[1], e.Room.Objects[0], e.Room.Objects[1], e);

            Console::CreateMessage("yeah yeah", 255, 0, 255);
            if (Player::Collider.GetX(true) >= e.Room.X + 128 / 256.f && Player::Collider.GetX(true) <= e.Room.X + 384 / 256.f) {
                if (Player::Collider.GetY(true) >= e.Room.Y - 4096 / 256.f && Player::Collider.GetY(true) <= e.Room.Y - 3584 / 256.f) {
                    if (Player::Collider.GetZ(true) >= e.Room.Z + 448 / 256.f && Player::Collider.GetZ(true) <= e.Room.Z + 960 / 256.f) {
                        Console::CreateMessage("yeah yeah", 0, 0, 255);
                        Player::BlinkTimer = 0;
                        Player::Collider.Position(120 + Rnd(-0.5f, 0.5f), 120.6F, 120 + Rnd(-0.5f, 0.5f), true);
                        Player::Collider.Rotate(0, 0, 0, true);
                        Player::Collider.Reset();

                        Player::DeathMessage = deathMsg;
                        playerInside015 = true;
                    }
                }
            }

            /*for (int i = 0; i < triggers.Length; i++) {
                Trigger@ v = triggers[i];
                if (v.RoomName() == e.Room.Template.Name) {
                    if (v.Inside(@Player::Collider) && v.Name() == "enter015") {
                        Player::BlinkTimer = 0;
                        Player::Collider.Position(120 + Rnd(-0.5f, 0.5f), 120.6F, 120 + Rnd(-0.5f, 0.5f), true);
                        Player::Collider.Rotate(0, 0, 0, true);
                        Player::Collider.Reset();

                        Player::DeathMessage = deathMsg;
                        playerInside015 = true;
                    }
                }
            }*/
        }
        else if (playerInside015) {
            const int maxRange = 25;
            if ((Player::Collider.GetX(true) > 120 + maxRange || Player::Collider.GetX(true) < 120 - maxRange) || (Player::Collider.GetZ(true) > 120 + maxRange || Player::Collider.GetZ(true) < 120 - maxRange)) {
                Player::BlinkTimer = 0;
                Player::Collider.Position(120 + Rnd(-0.5f, 0.5f), Player::Collider.GetY(true) + 0.05f, 120 + Rnd(-0.5f, 0.5f), true);
                Player::Collider.Rotate(0, Rand(0,1)*180, 0, true);
                Player::Collider.Reset();

                Player::DeathMessage = deathMsg;
                Player::Injuries += (1.f/5.f);
                Player::Bloodloss += (1.f/5.f);
            }
        }
    }

    return false;
}