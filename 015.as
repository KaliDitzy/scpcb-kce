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

void Create015Room(string name, RoomDirection015 direction, float x, float y, float z) {
    string@ roomDirectory = "GFX/map/015/";
    Pivot@ room = LoadRMesh(roomDirectory + name + ".rm");
    room.Position(x, y, z, true);
}

void Generate015Nightmare() {
    const int originX = 15360;
    const int originY = 15360;
    const int originZ = 15360;
    Create015Room(roomNames[0], RoomDirection015::FORWARD, originX, originY, originZ);
}