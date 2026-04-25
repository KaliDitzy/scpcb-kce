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
    TWO_WAY,
    FORK_LEFT,
    FORK_RIGHT
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

array<string> pipes;

void Register015Room(string name, RoomShape015 shape, int weight) {
    roomNames.InsertLast(name);
    roomShapes.InsertLast(shape);
    roomWeights.InsertLast(weight);
}

void Register015Pipes(string name) {
    pipes.InsertLast(name);
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
    Pivot@ room = LoadRMesh(roomDirectory + name + ".rmesh");
    room.Scale(1 / 256.f, 1 / 256.f, 1 / 256.f, true);
    room.Position(x, y, z, true);
    room.Rotate(0, directionToDegrees(direction), 0, true);

    if (name.Find("left") == -1) {
        const string meshName = pipes[Rand(0, pipes.Length - 1)];
        Mesh@ Mesh = LoadMesh("GFX\\map\\props\\015_pipes_" + meshName + ".b3d", room);
        Mesh.Position(Mesh.GetX(true), Mesh.GetY(true) - (25.61607f / 256.f), Mesh.GetZ(true), true);
        Mesh.SetType(1);
    }

    if (name.Find("right") == -1) {
        const string meshName = pipes[Rand(0, pipes.Length - 1)];
        Mesh@ Mesh = LoadMesh("GFX\\map\\props\\015_pipes_" + meshName + ".b3d", room);
        Mesh.Position(Mesh.GetX(true), Mesh.GetY(true) - (25.61607f / 256.f), Mesh.GetZ(true), true);
        Mesh.Rotate(0,180,0);
        Mesh.SetType(1);
    }

    //const string rightName = leftPipes[Rand(0, rightPipes.Length - 1)];
    //Mesh@ rightMesh = LoadMesh("GFX\\map\\props\\015_pipes_right_" + rightName + ".b3d", room);
}

int GridPos(float n) {
    return n * 4;
}

void Generate015Nightmare() {
    const int originX = 120;
    const int originY = 120;
    const int originZ = 120;

    // generate one part of 015
    for (int i = -10; i < 10; i++) {
        if (Rnd(0, 1) > 0.75f) { // UNUSED FOR NOW

            int direction = Rand(0,1);
            if (direction == 0) {
                int roomIndex = RandomStringPickWeightedIndex015(FORK_RIGHT);
                Create015Room(roomNames[roomIndex], RoomDirection015::FORWARD, originX, originY, originZ + GridPos(i));

                for (int j = 0; j < 10; j++) {
                    roomIndex = RandomStringPickWeightedIndex015(TWO_WAY);
                    Create015Room(roomNames[roomIndex], RoomDirection015::LEFT, originX + GridPos(j + 1), originY, originZ + GridPos(i));
                }
            }
            else {
                int roomIndex = RandomStringPickWeightedIndex015(FORK_LEFT);
                Create015Room(roomNames[roomIndex], RoomDirection015::FORWARD, originX, originY, originZ + GridPos(i));

                for (int j = 0; j < 10; j++) {
                    roomIndex = RandomStringPickWeightedIndex015(TWO_WAY);
                    Create015Room(roomNames[roomIndex], RoomDirection015::RIGHT, originX - GridPos(j + 1), originY, originZ + GridPos(i));
                }
            }
        }
        else {
            int roomIndex = RandomStringPickWeightedIndex015(TWO_WAY);
            Create015Room(roomNames[roomIndex], RoomDirection015::FORWARD, originX, originY, originZ + GridPos(i));
        }
    }
}

int lostCounter_015 = 0;
const string lostMsg1_015 = "\"Wait... which way is out, again?\"";
const string lostMsg2_015 = "You feel hopeless.";
const string lostMsg3_015 = "Your mouth is becoming dry, and you are very hungry.";
const string lostMsg4_015 = "You are starting to feel faint.";

void Lost015() {
    lostCounter_015++;

    switch(lostCounter_015) {
        case 1:
            Player::Message = lostMsg1_015;
            break;
        case 2:
            Player::Message = lostMsg2_015;
            break;
        case 3:
            Player::Message = lostMsg3_015;
            break;
        case 4:
            Player::Message = lostMsg4_015;
            break;
        default:
            Player::Message = "";
            break;
    }
    Player::MessageTimer = 70 * 7;
}