import 'dart:math';

abstract class SpaceShip {
  double health = 0;
  double firePower = 0;

  SpaceShip(this.health, this.firePower);

  void hit(double enemyFire);
  void isDestroyed();
}

/// document
class ArmoredSpaceShip extends SpaceShip {
  ArmoredSpaceShip({health, firePower}) : super(health, firePower);

  @override
  void hit(double enemyFire) {
    final random = Random();
    int rng = 1 + random.nextInt(40);
    double hit = rng / 100;
    double damage = enemyFire - (enemyFire * hit);
    health = health - damage;
    print('High Speed Spaceship attacks Armor Space Ship');
    print('Damage inflicted: $damage');

    isDestroyed();
  }

  @override
  void isDestroyed() {
    if (health <= 0) {
      print('');
      print('Armor Space Ship is destroyed');
      print('High Speed Spaceship wins !');
    } else {
      print('Armor Space Ship remaining health: $health');
      print('');
    }
  }
}

/// document
class HighSpeedSpaceShip extends SpaceShip {
  HighSpeedSpaceShip({health, firePower}) : super(health, firePower);

  @override
  void hit(double enemyFire) {
    final random = Random();
    bool rng = random.nextBool();
    print('Armor Spaceship attacks High Speed Spaceship');
    if (rng == true) {
      health = health - enemyFire;
      print('Damage inflicted: $enemyFire');
    } else {
      print('Dodged, no damage inflicted !');
    }

    isDestroyed();
  }

  @override
  void isDestroyed() {
    if (health <= 0) {
      print('');
      print('High Speed Spaceship is destroyed');
      print('Armor Spaceship wins !');
    } else {
      print('Remaining health: $health');
      print('');
    }
  }
}

/// document
class BattleField {
  void startBattle(SpaceShip sp1, SpaceShip sp2) async {
    while (sp1.health > 0 && sp2.health > 0) {
      await Future.delayed(Duration(seconds: 1), () {
        final random = Random();
        int rng = random.nextInt(2);
        if (rng <= 0) {
          sp1.hit(sp2.firePower);
        } else {
          sp2.hit(sp1.firePower);
        }
      });
    }
  }
}

/// entry point
void main() {
  ArmoredSpaceShip ship1 = ArmoredSpaceShip(health: 1000.0, firePower: 50.0);

  HighSpeedSpaceShip ship2 = HighSpeedSpaceShip(health: 200.0, firePower: 250.0);

  BattleField().startBattle(ship1, ship2);
}