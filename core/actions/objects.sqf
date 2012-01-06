// Testing Git
_type = (_this select 3) select 0;

if (_type == "ROTATE_LEFT") then
{
    RPP_var_object_rotation = RPP_var_object_rotation + 5;
};

if (_type == "ROTATE_RIGHT") then
{
    RPP_var_object_rotation = RPP_var_object_rotation - 5;
};

if (_type == "RAISE") then
{
    RPP_var_object_height = RPP_var_object_height + 0.25;
};

if (_type == "LOWER") then
{
    RPP_var_object_height = RPP_var_object_height - 0.25;
};

if (_type == "PUSH") then
{
    RPP_var_object_distance = RPP_var_object_distance + 0.25;
};
if (_type == "PULL") then
{
    RPP_var_object_distance = RPP_var_object_distance - 0.25;
};

if (_type == "PLACE") then
{
    RPP_var_object_isPlacing = false;
};

if (_type == "BEND") then
{
    if (RPP_var_object_bend) then
    {
        RPP_var_object_bend = false;
    }
    else
    {
        RPP_var_object_bend = true;
    };
};

