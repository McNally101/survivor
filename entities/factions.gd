class_name Faction

enum Type { PLAYER, ENEMY }

const ATTACK_LAYER := {
	Type.PLAYER: 1 << 6,
	Type.ENEMY: 1 << 7,
}

const HURT_MASK := {
	Type.PLAYER: 1 << 7,
	Type.ENEMY: 1 << 6,
}


static func attack_layer(t: Type) -> int:
	return ATTACK_LAYER[t]

static func hurt_mask(t: Type) -> int:
	return HURT_MASK[t]
