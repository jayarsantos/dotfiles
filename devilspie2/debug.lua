debug_print("Application: " .. get_application_name())
debug_print("Window: " .. get_window_name());

if (get_window_name() == "Mozilla Firefox") then
    maximize();
    set_window_workspace(2);
end
