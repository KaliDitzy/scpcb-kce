using namespace B3D;
using namespace CB;

#include "library.as"

array<string> itemNames;
array<int> itemWeightsLCZ;
array<int> itemWeightsHCZ;
array<int> itemWeightsEZ;

void RegisterRandomItem(string name, int weightLCZ, int weightHCZ, int weightEZ) {
    itemNames.InsertLast(name);
    itemWeightsLCZ.InsertLast(weightLCZ);
    itemWeightsHCZ.InsertLast(weightHCZ);
    itemWeightsEZ.InsertLast(weightEZ);
}

string RandomStringPickWeightedZones(const array<string>& strings, const array<int>& weightsLCZ, const array<int>& weightsHCZ, const array<int>& weightsEZ, int zone) {
    if(zone == 2) {
        int totalWeight = 0;
        foreach(int v : weightsHCZ) { totalWeight += v; }

        int picker = Rnd(totalWeight); int ticker = 0; int i = 0;
        foreach(int v : weightsHCZ) {
            ticker += v;
            if (ticker > picker) { return strings[i]; }
            i++;
        }
    }
    else if(zone == 3) {
        int totalWeight = 0;
        foreach(int v : weightsEZ) { totalWeight += v; }

        int picker = Rnd(totalWeight); int ticker = 0; int i = 0;
        foreach(int v : weightsEZ) {
            ticker += v;
            if (ticker > picker) { return strings[i]; }
            i++;
        }
    }
    else {
        int totalWeight = 0;
        foreach(int v : weightsLCZ) { totalWeight += v; }

        int picker = Rnd(totalWeight); int ticker = 0; int i = 0;
        foreach(int v : weightsLCZ) {
            ticker += v;
            if (ticker > picker) { return strings[i]; }
            i++;
        }
    }

    return "";
}

void FillRoom_RandomItems(Room@ r) {
    if (Rnd(0,1) < 0.75f) { return; }
    
    float targetX = r.X;
    float targetY = r.Y + 128 / 256.f;
    float targetZ = r.Z;

    Decal@ blood = Decal(Rand(2,3), targetX, 1 / 256.f, targetZ, 90, Rnd(0,360), 0);
    blood.Size = Rnd(0.3f,0.6f);
    blood.Object.ScaleSprite(blood.Size, blood.Size);

    NPC@ body = NPC(NPC::Type::ClassD, targetX, targetY, targetZ);
    body.State = 3;
    body.SetNPCFrame(19);
    body.IsDead = 1;
    if ( Rnd(0,1) > 0.85 ) { body.Texture = "GFX\\npcs\\body1.jpg"; } else { body.Texture = "GFX\\npcs\\body2.jpg"; }
    float rot = Rnd(0,360);
    body.Collider.Rotate(0, rot, 0);
    body.Collider.Position(body.Collider.GetX(true) - Cos(rot-90.f)/2.f, body.Collider.GetY(true), body.Collider.GetZ(true) - Sin(rot-90.f)/2.f);
    Texture@ tex = LoadTexture(body.Texture);
    Mesh@ mesh = cast<Mesh@>(cast<Model@>(body.Object));
    mesh.SetTexture(tex);
    tex.Free();

    string result = RandomStringPickWeightedZones(itemNames, itemWeightsLCZ, itemWeightsHCZ, itemWeightsEZ, r.Zone);
    float x = Rnd(64, 128);
    float z = Rnd(64, 128);
    Item@ it = Item(result, targetX + x / 256.f, targetY, targetZ + z / 256.f);
    it.Collider.Rotate(0, Rnd(0,360), 0);
    it.Collider.SetParent(r.Object);
}