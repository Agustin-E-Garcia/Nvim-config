local GetUProject = function()
    local matches = vim.fn.glob("*.uproject", false, true)
    if #matches == 0 then
        print("no .uproject file found in current directory")
    else
        return matches[1]
    end
end, {}


vim.api.nvim_create_user_command('UECompile', function()
    local cwd = vim.fn.getcwd()

    -- Find first .uproject file
    local matches = vim.fn.glob("*.uproject", false, true)
    if #matches == 0 then
        print("No .uproject file found in current directory.")
        return
    end

    local uproject_file = matches[1]
    local project_path = cwd .. "/" .. uproject_file
    local project_name = uproject_file:gsub("%.uproject$", "") -- Strip ".uproject"

    local engine_path = "/home/Agustin/extra/GameDev/Unreal/UnrealEngine-git/Engine/Build/BatchFiles/Linux/Build.sh"

    -- Build command
    local build_cmd = string.format(
        "%s -mode=GenerateClangDatabase -NoExecCodeGenActions -project=\"%s\" %sEditor Linux Development",
        engine_path, project_path, project_name
    )

    -- Path to generated compile_commands.json
    local src_compile_db = "/home/Agustin/extra/GameDev/Unreal/UnrealEngine-git/compile_commands.json"
    -- Destination: project root (same folder as .uproject)
    local dst_compile_db = string.format("%s/compile_commands.json", cwd)

    -- Chain the build and copy
    local cmd = string.format("%s && cp %s %s", build_cmd, src_compile_db, dst_compile_db)

    vim.cmd("split | terminal " .. cmd)
end, {
    nargs = 0,
    desc = 'Generate clang compile_commands.json for the .uproject in current dir and copy it to project root',
})

vim.api.nvim_create_user_command('UEditor', function()
    local cwd = vim.fn.getcwd()
    local uproject_file = GetUProject()
    local project_path = cwd .. "/" .. uproject_file

    local engine_path = "/home/Agustin/extra/GameDev/Unreal/UnrealEngine-git/Engine/Binaries/Linux/UnrealEditor"
    local dxc_path = "/home/Agustin/extra/GameDev/Unreal/UnrealEngine-git/Engine/Extras/ThirdPartyNotUE/DirectXShaderCompiler/bin"

    local cmd = string.format(
        'env LD_LIBRARY_PATH="%s:$LD_LIBRARY_PATH" %q %q &',
        dxc_path,
        engine_path,
        project_path
    )

    os.execute(cmd)
end, {})
