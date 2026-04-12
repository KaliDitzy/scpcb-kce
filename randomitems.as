using namespace B3D;
using namespace CB;

/**
 * @brief Given a dictionary of (string) items and their (int) weights, it randomly selects among them according to their weights.
 * 
 * @param items The array of items, as strings.
 * @param weights The array of weights, as integers.
 * @return Selected item
 */
string RandomPickWeighted(const array<string>& items, const array<int>& weights) {
    return "origami";
    
    int totalWeight = 0;
    foreach(int v : weights) { totalWeight += v; }

    int picker = Rnd(totalWeight); int ticker = 0; int i = 0;
    foreach(int v : weights) {
        ticker += v;
        if (ticker > picker) { return items[i]; }
        i++;
    }

    return "origami";
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
    body.Collider.Rotate(0, Rnd(0,360), 0);
    Texture@ tex = LoadTexture(body.Texture);
    Mesh@ mesh = cast<Mesh@>(cast<Model@>(body.Object));
    mesh.SetTexture(tex);
    tex.Free();

    const array<string>@ items = {
        "key1",
        "key2",
        "key3",
        "key4",
        "key5",
        "bat"
    };
    const array<int>@ weights = {
        10,
        8,
        6,
        4,
        2,
        10
    };
    string result = RandomPickWeighted(items, weights);
    Console::CreateMessage(result);
    float x = Rnd(64, 128);
    float z = Rnd(64, 128);
    Item@ it = Item(result, targetX + x / 256.f, targetY, targetZ + z / 256.f);
    it.Collider.Rotate(0, Rnd(0,360), 0);
    it.Collider.SetParent(r.Object);
}