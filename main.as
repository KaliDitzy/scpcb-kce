using namespace B3D;
using namespace CB;

#include "library.as"
#include "entities.as"
#include "randomitems.as"
#include "015.as"

NPC@ scp131a; bool scp131a_spawned;
NPC@ scp131b; bool scp131b_spawned;

Music music015;
Music music015inside;

array<string> archiveItemNames;
array<int> archiveItemWeights2;
array<int> archiveItemWeights3;
array<int> archiveItemWeights4;

bool playerInside015 = false;
const string deathMsg_015 = "A severely mutilated D-Class was discovered within SCP-015, the subject appeared thin likely from extended malnourishment prior to their expiration.\nSCP-015 grew plumbing through, in, and around the subject's body, rendering it unrecognizable at first glance, though DNA testing later revealed the identity of the corpse as belonging to D-9341.";

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
    music015 = Music::RegisterCustom("SFX\\Music\\015.ogg");
    music015inside = Music::RegisterCustom("SFX\\Music\\015Inside.ogg");

    RegisterRandomItem("key1", 20, 5, 20);
    RegisterRandomItem("key2", 16, 8, 16);
    RegisterRandomItem("key3", 12, 12, 12);
    RegisterRandomItem("key4", 6, 6, 6);
    RegisterRandomItem("key5", 2, 2, 2);
    RegisterRandomItem("bat", 20, 20, 20);
    RegisterRandomItem("doc008", 0, 1, 1);
    RegisterRandomItem("doc012", 1, 1, 1);
    RegisterRandomItem("doc015", 1, 1, 1);
    RegisterRandomItem("doc018", 1, 1, 1);
    RegisterRandomItem("doc035", 1, 1, 1);
    RegisterRandomItem("doc049", 1, 1, 1);
    RegisterRandomItem("doc079", 0, 1, 1);
    RegisterRandomItem("doc096", 1, 1, 1);
    RegisterRandomItem("doc106", 1, 1, 1);
    RegisterRandomItem("doc173", 1, 1, 1);
    RegisterRandomItem("doc372", 1, 1, 1);
    RegisterRandomItem("doc427", 1, 1, 1);
    RegisterRandomItem("doc500", 1, 1, 1);
    RegisterRandomItem("doc513", 1, 1, 1);
    RegisterRandomItem("doc682", 0, 1, 1);
    RegisterRandomItem("doc714", 1, 1, 1);
    RegisterRandomItem("doc860", 1, 1, 1);
    RegisterRandomItem("doc895", 1, 1, 1);
    RegisterRandomItem("doc939", 1, 1, 1);
    RegisterRandomItem("doc966", 1, 1, 1);
    RegisterRandomItem("doc970", 1, 1, 1);
    RegisterRandomItem("doc1048", 1, 1, 1);
    RegisterRandomItem("doc1162", 1, 1, 1);
    RegisterRandomItem("doc1499", 1, 1, 1);
    RegisterRandomItem("doc8601", 1, 1, 1);

    Register015Room("kce_015_hall", RoomShape015::TWO_WAY, 100);
    Register015Room("kce_015_fork_left", RoomShape015::FORK_LEFT, 100);
    Register015Room("kce_015_fork_right", RoomShape015::FORK_RIGHT, 100);
    Register015Pipes("1");
    Register015Pipes("2");

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
    RegisterArchiveItem("doc015", 1, 5, 5);
    RegisterArchiveItem("doc018", 5, 5, 5);
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
    RegisterArchiveItem("doc1162", 1, 5, 5);
    RegisterArchiveItem("doc1499", 1, 5, 5);
    RegisterArchiveItem("doc8601", 1, 5, 5);
    RegisterArchiveItem("origami", 10, 25, 25);
    RegisterArchiveItem("mastercard", 10, 25, 25);
    RegisterArchiveItem("playingcard", 10, 25, 25);

    return false;
}

bool Hook_InitializeEvents() {
    Event::Create("kce_018cc", "kce_018cc", 0, 1);
    Event::Create("kce_015cc", "kce_015cc", 0, 1);

    return false;
}

bool Hook_LoadRoomTemplateEntity(CB::RoomTemplate@ rt, int version, B3D::Stream@ f, string name) {
    if (name == "junk") {
        float x = f.ReadFloat();
        float y = f.ReadFloat();
        float z = f.ReadFloat();

        string file1 = f.ReadString();
        string file2 = f.ReadString();
        string file3 = f.ReadString();

        Vector3 minPos;
        minPos.From(f.ReadString());
        Vector3 maxPos;
        maxPos.From(f.ReadString());

        Vector3 maxRot;
        maxRot.From(f.ReadString());
        
        float minScale = f.ReadFloat();
        float maxScale = f.ReadFloat();
        
        int minObj = f.ReadInt();
        int maxObj = f.ReadInt();

        RegisterTempJunk(TempJunk(rt, x, y, z, file1, file2, file3, minPos, maxPos, maxRot, minScale, maxScale, minObj, maxObj));

        return true;
    }
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

        /*
        Sprite@ spotlight = Sprite::Create(r.Object);
        spotlight.Position(0, 2, 0, false);
        spotlight.Scale(0.5, 1, 1, true);

        Texture@ spotlightTex = LoadTexture("GFX\\spotlightsprite.png", 1);
        spotlight.SetTexture(spotlightTex);
        spotlight.set_Blend(3);
        spotlight.SetOrder(-1);
        spotlight.SetFX(1);
        spotlight.SetViewMode(0);
        */
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

        Generate015Nightmare();
    }

    return false;
}
bool Hook_PostFillRoom(Room@ r) {
    FillRoom_RandomItems(r);

    for (int i = 0; i < tempJunk.Length; i++) {
        if (tempJunk[i].rt.Name == r.Template.Name) { tempJunk[i].Spawn(@r); }
    }

    return false;
}

void Hook_Update() {
    if (!scp131a_spawned && !Menu::IsMainMenuOpen) {
        @scp131a = NPC(NPC::Type::ClassD, 0, 0, 0);
        scp131a.ID = 13101;
        scp131a.NVName = "SCP-131-A";
        scp131a.Collider.SetRadius(0.125, 0.125);
        scp131a.CollRadius = 0.125;
        scp131a.Idle = 30;

        //scp131a.Texture = "GFX\\npcs\\body1.jpg";
        //Texture@ tex = LoadTexture(scp131a.Texture);
        //Mesh@ mesh = cast<Mesh@>(cast<Model@>(scp131a.Object));
        //mesh.SetTexture(tex);
        //tex.Free();

        scp131a_spawned = true;
    }

    if (!scp131b_spawned && !Menu::IsMainMenuOpen) {
        @scp131b = NPC(NPC::Type::ClassD, 0, 0, 0);
        scp131b.ID = 131012;
        scp131b.NVName = "SCP-131-B";
        scp131b.Collider.SetRadius(0.125, 0.125);
        scp131b.CollRadius = 0.125;
        scp131b.Idle = 30;

        //scp131b.Texture = "GFX\\npcs\\body1.jpg";
        //Texture@ tex = LoadTexture(scp131b.Texture);
        //Mesh@ mesh = cast<Mesh@>(cast<Model@>(scp131b.Object));
        //mesh.SetTexture(tex);
        //tex.Free();
        
        scp131b_spawned = true;
    }
}
bool Hook_UpdateEvent(Event@ e) {
    bool playerIsInRoom = (@e.Room == @Player::CurrentRoom);
    if (e.Name == "room1archive") {
        return true;
    }
    else if (e.Name == "kce_018cc" && playerIsInRoom) {
        e.State2 = Event::UpdateElevator(e.State2, e.Room.Doors[0], e.Room.Doors[1], e.Room.Objects[0], e.Room.Objects[1], e);
    }
    else if (e.Name == "kce_015cc") {
        if (playerIsInRoom && !playerInside015) {
            e.State2 = Event::UpdateElevator(e.State2, e.Room.Doors[0], e.Room.Doors[1], e.Room.Objects[0], e.Room.Objects[1], e);

            if (Triggerbox::Check(e.Room, Player::Collider.GetX(true), Player::Collider.GetY(true), Player::Collider.GetZ(true)) == "enter015") {
                Player::BlinkTimer = 0;
                Player::Collider.Position(120 + Rnd(-0.4f, 0.4f), 120.6F, 120 + Rnd(-0.5f, 0.5f), true);
                Player::Collider.Rotate(0, 0, 0, true);
                Player::Collider.Reset();

                Player::DeathTimer = 120.f * 70.f;
                Player::DeathMessage = deathMsg_015;
                playerInside015 = true;
                Lost015();
            }
        }
        else if (playerInside015) {
            const int maxRange = 25;
            
            if ((Player::Collider.GetX(true) > 120 + maxRange || Player::Collider.GetX(true) < 120 - maxRange) || (Player::Collider.GetZ(true) > 120 + maxRange || Player::Collider.GetZ(true) < 120 - maxRange)) {
                Player::BlinkTimer = 0;
                Player::Collider.Position(120 + Rnd(-0.4f, 0.4f), Player::Collider.GetY(true) + 0.05f, 120 + Rnd(-0.5f, 0.5f), true);
                Player::Collider.Rotate(0, Rand(0,1)*180, 0, true);
                Player::Collider.Reset();

                Player::DeathMessage = deathMsg_015;
                Player::Injuries += (1.f/5.f);
                Player::Bloodloss += (100.f/5.f);
                Lost015();
            }
        }

        if (playerInside015) {
            Music::ShouldPlay = music015inside;
        }
        else if (playerIsInRoom && (Player::Collider.GetY(true) < -1)) {
            Music::ShouldPlay = music015;
        }
    }

    return false;
}

bool Hook_UpdateNPC(NPC@ n) {
    if (n.ID == scp131a.ID || n.ID == scp131b.ID) {
        // n.State == Target Speed
        // n.Idle == Movement Direction
        // n.State2 == Target Angle

        float adjustedFPSFactor = FPSFactor / 70.f;

        float playerDistance = DistanceSquared(
            n.Collider.GetX(true),
            n.Collider.GetY(true),
            n.Collider.GetZ(true),
            Player::Collider.GetX(true),
            Player::Collider.GetY(true),
            Player::Collider.GetZ(true)
        );

        float distance173 = DistanceSquared(
            n.Collider.GetX(true),
            n.Collider.GetY(true),
            n.Collider.GetZ(true),
            NPC::Current173.Collider.GetX(true),
            NPC::Current173.Collider.GetY(true),
            NPC::Current173.Collider.GetZ(true)
        );

        float currentAngle = n.Collider.GetYaw(true);
        float speed = .25f;

        if (playerDistance > 6.f) { n.IdleTimer += adjustedFPSFactor; } else { n.IdleTimer = 0; }
        if (playerDistance < 1.f && Rand(0,25) == 0) { n.State = -speed * 25.f; n.Idle = 0; }

        if (distance173 < 3.f) {
            n.Collider.PointAt(NPC::Current173.Collider);
            n.State2 = n.Collider.GetYaw(true);
            n.Collider.Rotate(0, currentAngle, 0, true);
        }
        else {
            n.Collider.PointAt(Player::Collider);
            n.State2 = n.Collider.GetYaw(true);
            n.Collider.Rotate(0, currentAngle, 0, true);
        }
        
        if (n.IdleTimer >= 30.f) {
            // Out of bounds, waiting to be placed.

            n.DropSpeed = 0;
            n.Collider.Position(-131, -131, -131);
            n.Collider.Reset();

            if (Rand(0, 200) == 0) {
                n.IdleTimer = -10; // Place SCP-131.
            }
        }
        else if (n.IdleTimer < 0) {
            // Places SCP-131.
            Console::CreateMessage(n.NVName + " is being placed.", 255, 255, 0);

            //float targetX = Player::CurrentRoom.X + (Rand(0,1) * 8) - 4;
            //float targetZ = Player::CurrentRoom.Z + (Rand(0,1) * 8) - 4;
            float targetX = Player::CurrentRoom.X; float targetZ = Player::CurrentRoom.Z;
            n.Collider.Position(targetX + Rnd(-0.5f,0.5f), Player::CurrentRoom.Y + 0.35f, targetZ + Rnd(-0.5f,0.5f), true);
            n.Collider.Reset();

            n.IdleTimer = 0;
        }
        else {
            // SCP-131 behavior.

            n.DropSpeed = -0.1f;

            if (currentAngle < n.State2) { n.Collider.Turn(0, -adjustedFPSFactor * 45, 0, true); }
            else if (currentAngle > n.State2) { n.Collider.Turn(0, adjustedFPSFactor * 45, 0, true); }

            if (n.Idle == 0) { currentAngle += 90.f; }

            // Randomly move left or right.
            if (Rand(0, 500) == 0) { n.State = speed * (Rand(0,1) * 2 - 1); n.Idle = 1; }
            n.Collider.Translate(adjustedFPSFactor * n.CurrentSpeed * Cos(currentAngle), 0, adjustedFPSFactor * n.CurrentSpeed * Sin(currentAngle), false);
        }

        if (Rand(0,200) == 0) { n.State = 0; }
        if (n.CurrentSpeed != n.State) {
            n.CurrentSpeed = ((n.CurrentSpeed * 19.f) + n.State) / 20.f;
        }

        n.Object.Position(n.Collider.GetX(true), n.Collider.GetY(true) - 0.32, n.Collider.GetZ(true), true);
        n.Object.Rotate(0, n.Collider.GetYaw(true), 0, true);

        return true;
    }
    return false;
}
