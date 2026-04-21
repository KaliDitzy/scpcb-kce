using namespace B3D;
using namespace CB;

#include "library.as"
#include "triggers.as"
#include "randomitems.as"
#include "015.as"

bool playerInside015 = false;

array<string> archiveItemNames;
array<int> archiveItemWeights2;
array<int> archiveItemWeights3;
array<int> archiveItemWeights4;

void RegisterArchiveItem(string itemName, int level2Weight, int level3Weight, int level4Weight) {
    archiveItemNames.InsertLast(itemName);
    archiveItemWeights2.InsertLast(level2Weight);
    archiveItemWeights3.InsertLast(level3Weight);
    archiveItemWeights4.InsertLast(level4Weight);
}

void SpawnItems(Room@ r, float x, float y, float z, int maxItems, float spacing, const array<string>& strings, const array<int>& weights) {
    int numItems = RandomBiasedHigh(0, maxItems);
    float middle = (numItems - 1) / 2.f;
    for (int i = 0; i < numItems; i++) {
        string result = RandomStringPickWeighted(strings, weights);
        float offset = (i - middle) * spacing;

        Item@ it = Item(result, r.X + x / 256.f, r.Y + y / 256.f, r.Z + (z + offset) / 256.f);
        it.Collider.Rotate(0, Rnd(0,360), 0);
        it.Collider.SetParent(r.Object);
    }
}
void SpawnItemsLow(Room@ r, float x, float y, float z, int maxItems, float spacing, const array<string>& strings, const array<int>& weights) {
    int numItems = RandomBiasedLow(0, maxItems);
    float middle = (numItems - 1) / 2.f;
    for (int i = 0; i < numItems; i++) {
        string result = RandomStringPickWeighted(strings, weights);
        float offset = (i - middle) * spacing;

        Item@ it = Item(result, r.X + x / 256.f, r.Y + y / 256.f, r.Z + (z + offset) / 256.f);
        it.Collider.Rotate(0, Rnd(0,360), 0);
        it.Collider.SetParent(r.Object);
    }
}

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

    RegisterArchiveItem("clipboard", 15, 15, 5);
    RegisterArchiveItem("finefirstaid", 1, 5, 20);
    RegisterArchiveItem("firstaid", 30, 50, 100);
    RegisterArchiveItem("gasmask", 75, 50, 50);
    RegisterArchiveItem("supernv", 0, 10, 50);
    RegisterArchiveItem("nvgoggles", 0, 30, 100);
    RegisterArchiveItem("radio", 25, 50, 100);
    RegisterArchiveItem("snav", 50, 100, 25);
    RegisterArchiveItem("key1", 100, 50, 25);
    RegisterArchiveItem("key2", 30, 50, 15);
    RegisterArchiveItem("key3", 10, 50, 100);
    RegisterArchiveItem("key4", 0, 2, 50);
    RegisterArchiveItem("key5", 0, 0, 2);
    RegisterArchiveItem("bat", 120, 100, 50);
    RegisterArchiveItem("doc008", 0, 1, 5);
    RegisterArchiveItem("doc012", 1, 5, 5);
    RegisterArchiveItem("doc035", 2, 5, 5);
    RegisterArchiveItem("doc049", 1, 5, 5);
    RegisterArchiveItem("doc079", 0, 1, 5);
    RegisterArchiveItem("doc096", 0, 1, 5);
    RegisterArchiveItem("doc106", 0, 1, 5);
    RegisterArchiveItem("doc173", 5, 5, 5);
    RegisterArchiveItem("doc372", 5, 5, 1);
    RegisterArchiveItem("doc427", 2, 5, 5);
    RegisterArchiveItem("doc500", 0, 1, 5);
    RegisterArchiveItem("doc513", 1, 5, 5);
    RegisterArchiveItem("doc682", 0, 1, 5);
    RegisterArchiveItem("doc714", 5, 5, 1);
    RegisterArchiveItem("doc860", 0, 1, 5);
    RegisterArchiveItem("doc895", 1, 5, 5);
    RegisterArchiveItem("doc939", 5, 5, 5);
    RegisterArchiveItem("doc966", 1, 5, 5);
    RegisterArchiveItem("doc970", 5, 5, 5);
    RegisterArchiveItem("doc1048", 1, 5, 5);
    RegisterArchiveItem("doc1123", 1, 5, 5);
    RegisterArchiveItem("doc1162", 1, 5, 5);
    RegisterArchiveItem("doc1499", 1, 5, 5);
    RegisterArchiveItem("doc8601", 1, 5, 5);
    RegisterArchiveItem("origami", 10, 25, 25);
    RegisterArchiveItem("mastercard", 10, 25, 25);
    RegisterArchiveItem("playingcard", 10, 25, 25);

    return false;
}

bool Hook_InitializeEvents() {
    CreateEvent("kce_018cc", "kce_018cc", 0, 1);
    CreateEvent("kce_015cc", "kce_015cc", 0, 1);

    return false;
}

bool Hook_FillRoom(Room@ r) {
    if(r.Template.Name == "room1archive") {
        // level 2
        SpawnItems(r, -720, 160, -128, 3, 64, archiveItemNames, archiveItemWeights2);
        SpawnItems(r, -720, 160, 256, 3, 64, archiveItemNames, archiveItemWeights2);
        SpawnItems(r, -720, 160, 720, 1, 64, archiveItemNames, archiveItemWeights2);

        SpawnItems(r, -368, 160, -128, 3, 64, archiveItemNames, archiveItemWeights2);
        SpawnItems(r, -368, 160, 224, 2, 64, archiveItemNames, archiveItemWeights2);
        SpawnItems(r, -368, 160, 640, 3, 64, archiveItemNames, archiveItemWeights2);
        // level 3
        SpawnItems(r, -144, 160, -112, 2, 64, archiveItemNames, archiveItemWeights3);
        SpawnItems(r, -144, 160, 256, 3, 64, archiveItemNames, archiveItemWeights3);
        SpawnItems(r, -144, 160, 640, 3, 64, archiveItemNames, archiveItemWeights3);

        SpawnItems(r, 144, 160, -64, 2, 64, archiveItemNames, archiveItemWeights3);
        SpawnItems(r, 144, 160, 256, 3, 64, archiveItemNames, archiveItemWeights3);
        // level 4
        
        SpawnItemsLow(r, -720, 160, 688, 2, 64, archiveItemNames, archiveItemWeights4);

        SpawnItemsLow(r, 368, 160, -128, 3, 64, archiveItemNames, archiveItemWeights4);

        return true;
    }
    else if(r.Template.Name == "kce_018cc") {
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
    if (e.Name == "room1archive") {
        return true;
    }
    else if (e.Name == "kce_018cc" && playerIsInRoom) {
        e.State2 = UpdateElevator(e.State2, e.Room.Doors[0], e.Room.Doors[1], e.Room.Objects[0], e.Room.Objects[1], e);
    }
    else if (e.Name == "kce_015cc") {
        const string deathMsg = "A severely mutilated D-Class was discovered within SCP-015, the subject appeared thin likely from extended malnourishment prior to their expiration.\nSCP-015 grew plumbing through, in, and around the subject's body, rendering it unrecognizable at first glance, though DNA testing later revealed the identity of the corpse as belonging to D-9341.";
        if (playerIsInRoom && !playerInside015) {
            e.State2 = UpdateElevator(e.State2, e.Room.Doors[0], e.Room.Doors[1], e.Room.Objects[0], e.Room.Objects[1], e);

            if (Triggerbox::Check(e.Room, Player::Collider.GetX(true), Player::Collider.GetY(true), Player::Collider.GetZ(true)) == "enter015") {
                Player::BlinkTimer = 0;
                Player::Collider.Position(120 + Rnd(-0.5f, 0.5f), 120.6F, 120 + Rnd(-0.5f, 0.5f), true);
                Player::Collider.Rotate(0, 0, 0, true);
                Player::Collider.Reset();

                Player::KillTimer = 120;
                Player::DeathMessage = deathMsg;
                playerInside015 = true;
            }
        }
        else if (playerInside015) {
            const int maxRange = 25;
            //Console::CreateMessage("yeah yeah", 196, 0, 255);
            if ((Player::Collider.GetX(true) > 120 + maxRange || Player::Collider.GetX(true) < 120 - maxRange) || (Player::Collider.GetZ(true) > 120 + maxRange || Player::Collider.GetZ(true) < 120 - maxRange)) {
                //Console::CreateMessage("yeah yeah", 0, 64, 255);

                Player::BlinkTimer = 0;
                Player::Collider.Position(120 + Rnd(-0.5f, 0.5f), Player::Collider.GetY(true) + 0.05f, 120 + Rnd(-0.5f, 0.5f), true);
                Player::Collider.Rotate(0, Rand(0,1)*180, 0, true);
                Player::Collider.Reset();

                Player::DeathMessage = deathMsg;
                Player::Injuries += (1.f/5.f);
                Player::Bloodloss += (100.f/5.f);
            }
        }
    }

    return false;
}