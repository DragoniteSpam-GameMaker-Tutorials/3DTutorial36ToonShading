/// @description Draw the 3D world
draw_clear(c_black);

shader_set(shd_basic_3d_stuff);

// 3D projections require a view and projection matrix
var camera = camera_get_active();
var camera_distance = 160;

var xfrom = Player.x;
var yfrom = Player.y;
var zfrom = Player.z + 64;
var xto = xfrom - camera_distance * dcos(Player.look_dir) * dcos(Player.look_pitch);
var yto = yfrom + camera_distance * dsin(Player.look_dir) * dcos(Player.look_pitch);
var zto = zfrom + camera_distance * dsin(Player.look_pitch);

view_mat = matrix_build_lookat(xfrom, yfrom, zfrom, xto, yto, zto, 0, 0, 1);
proj_mat = matrix_build_projection_perspective_fov(-60, -window_get_width() / window_get_height(), 1, 32000);
camera_set_view_mat(camera, view_mat);
camera_set_proj_mat(camera, proj_mat);
camera_apply(camera);

gpu_set_tex_repeat(true);
// Everything must be drawn after the 3D projection has been set
vertex_submit(vbuffer, pr_trianglelist, sprite_get_texture(spr_grass, 0));

shader_reset();

matrix_set(matrix_world, matrix_build(250, 250, 0, 0, 0, 0, 1, 1, 1));
vertex_submit(vb_link, pr_trianglelist, sprite_get_texture(spr_link, 0));
matrix_set(matrix_world, matrix_build_identity());