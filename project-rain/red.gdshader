shader_type spatial;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Set the diffuse color (ALBEDO) to pure green.
	ALBEDO = vec3(1.0, 0.0, 0.2);
}

// Optionally, you can override the light function if needed.
// void light() {
//     // Custom light processing goes here.
// }
