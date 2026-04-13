using namespace B3D;
using namespace CB;

enum RoomShape015 {
    ONE_WAY,
    TWO_WAY,
    TWO_WAY_CORNER,
    THREE_WAY,
    FOUR_WAY
}

enum RoomDirection015 {
    FORWARD,
    RIGHT,
    BACKWARD,
    LEFT
}

array<string> roomNames;
array<RoomShape015> roomShapes;
array<int> roomWeights;

void Register015Room(string name, RoomShape015 shape, int weight) {
    roomNames.InsertLast(name);
    roomShapes.InsertLast(shape);
    roomWeights.InsertLast(weight);
}

int directionToDegrees(RoomDirection015 direction) {
    if (direction == RoomDirection015::FORWARD) { return 0; }
    else if (direction == RoomDirection015::RIGHT) { return 90; }
    else if (direction == RoomDirection015::BACKWARD) { return 180; }
    else if (direction == RoomDirection015::LEFT) { return 270; }
    return 0;
}

void Create015Room(const string name, RoomDirection015 direction, float x, float y, float z) {
    string roomDirectory = "GFX/map/015/";
    Pivot@ room = LoadRMesh(roomDirectory + name + ".rm");
    room.Scale(1 / 256.f, 1 / 256.f, 1 / 256.f, true);
    room.Position(x, y, z, true);
    room.Rotate(0, directionToDegrees(direction), 0, true);
}

int GridPos(float n) {
    return n * 4;
}

void Generate015Nightmare() {
    const int originX = 60;
    const int originY = 60;
    const int originZ = 60;
    for (int i = 0; i < 10; i++) {
        Create015Room("kce_015_hall", RoomDirection015::FORWARD, originX, originY, originZ + GridPos(i));
    }
}