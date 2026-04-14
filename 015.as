using namespace B3D;
using namespace CB;

#include "library.as"

/**
 * @brief Given a desired room shape, it will do a weighted pick of the registered SCP-015 rooms.
 * 
 * @param desiredShape The desired room shape.
 * @return Selected string index
 */
int RandomStringPickWeightedIndex015(const RoomShape015 desiredShape) {
    int totalWeight = 0; int i = -1;
    foreach(int v : roomWeights) {
        i++;
        if (roomShapes[i] != desiredShape) { continue; }
        totalWeight += v;
    }

    int picker = Rnd(totalWeight); int ticker = 0; i = -1;
    foreach(int v : roomWeights) {
        i++;
        if (roomShapes[i] != desiredShape) { continue; }
        ticker += v;
        if (ticker > picker) { return i; }
    }

    return 0;
}

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
    string roomDirectory = "GFX/map/";
    Pivot@ room = LoadRMesh(roomDirectory + name + ".rm");
    room.Scale(1 / 256.f, 1 / 256.f, 1 / 256.f, true);
    room.Position(x, y, z, true);
    room.Rotate(0, directionToDegrees(direction), 0, true);
}

int GridPos(float n) {
    return n * 4;
}

void Generate015Nightmare() {
    const int originX = 120;
    const int originY = 120;
    const int originZ = 120;

    // generate one part of 015
    bool generatedDivergeLastIteration = false;
    for (int i = -10; i < 10; i++) {
        if (!generatedDivergeLastIteration && Rnd(0, 1) > 0.75f) {
            int roomIndex = RandomStringPickWeightedIndex015(THREE_WAY);

            int direction = Rand(0,1);
            int numberOfRooms = Rand(1,4);
            if (direction == 0) {
                Create015Room(roomNames[roomIndex], RoomDirection015::RIGHT, originX, originY, originZ + GridPos(i));

                for (int j = 0; j < numberOfRooms; j++) {
                    roomIndex = RandomStringPickWeightedIndex015(TWO_WAY);
                    Create015Room(roomNames[roomIndex], RoomDirection015::LEFT, originX + GridPos(j + 1), originY, originZ + GridPos(i));
                }
            }
            else {
                Create015Room(roomNames[roomIndex], RoomDirection015::LEFT, originX, originY, originZ + GridPos(i));

                for (int j = 0; j < numberOfRooms; j++) {
                    roomIndex = RandomStringPickWeightedIndex015(TWO_WAY);
                    Create015Room(roomNames[roomIndex], RoomDirection015::RIGHT, originX - GridPos(j + 1), originY, originZ + GridPos(i));
                }
            }

            generatedDivergeLastIteration = true;
        }
        else {
            int roomIndex = RandomStringPickWeightedIndex015(TWO_WAY);
            Create015Room(roomNames[roomIndex], RoomDirection015::FORWARD, originX, originY, originZ + GridPos(i));

            generatedDivergeLastIteration = false;
        }
    }
}