vim.api.nvim_create_user_command('UECompile', function()
    local cwd = vim.fn.getcwd()

    local matches = vim.fn.glob("*.uproject", false, true)
    if #matches == 0 then
        print("No .uproject file found in current directory.")
        return
    end

    local uproject_file = matches[1]
    local project_path = cwd .. "/" .. uproject_file
    local project_name = uproject_file:gsub("%.uproject$", "")

    local engine_path = "/home/Agustin/extra/GameDev/Unreal/UnrealEngine-git/Engine/Build/BatchFiles/Linux/Build.sh"

    -- Fast build: skip UHT/codegen for quick iteration
    local build_cmd = string.format(
        "%s -mode=GenerateClangDatabase -NoExecCodeGenActions -project=\"%s\" %sEditor Linux Development",
        engine_path, project_path, project_name
    )

    -- Copy compile_commands.json for LSP
    local src_compile_db = "/home/Agustin/extra/GameDev/Unreal/UnrealEngine-git/compile_commands.json"
    local dst_compile_db = string.format("%s/compile_commands.json", cwd)

    local cmd = string.format("%s && cp %s %s", build_cmd, src_compile_db, dst_compile_db)

    vim.cmd("split | terminal " .. cmd)
end, {
    nargs = 0,
    desc = 'Fast compile (no UHT) for coding in nvim',
})

vim.api.nvim_create_user_command('UERun', function()
    local cwd = vim.fn.getcwd()

    local matches = vim.fn.glob("*.uproject", false, true)
    if #matches == 0 then
        print("No .uproject file found in current direct:ory.")
        return
    end

    local uproject_file = matches[1]
    local project_path = cwd .. "/" .. uproject_file
    local project_name = uproject_file:gsub("%.uproject$", "")

    local engine_path = "/home/Agustin/extra/GameDev/Unreal/UnrealEngine-git/Engine/Build/BatchFiles/Linux/Build.sh"
    local editor_path = "/home/Agustin/extra/GameDev/Unreal/UnrealEngine-git/Engine/Binaries/Linux/UnrealEditor"
    local dxc_path = "/home/Agustin/extra/GameDev/Unreal/UnrealEngine-git/Engine/Extras/ThirdPartyNotUE/DirectXShaderCompiler/bin"

    -- Full build with UHT
    local build_cmd = string.format(
        "%s -project=\"%s\" %sEditor Linux Development",
        engine_path, project_path, project_name
    )

    local src_compile_db = "/home/Agustin/extra/GameDev/Unreal/UnrealEngine-git/compile_commands.json"
    local dst_compile_db = string.format("%s/compile_commands.json", cwd)

    -- Chain: build → copy compile_commands.json → launch editor
    local cmd = string.format(
        "%s && cp %s %s && env LD_LIBRARY_PATH=\"%s:$LD_LIBRARY_PATH\" %q %q",
        build_cmd,
        src_compile_db, dst_compile_db,
        dxc_path,
        editor_path, project_path
    )

    vim.cmd("split | terminal " .. cmd)
end, {
    nargs = 0,
    desc = 'Full compile (with UHT) and launch Unreal Editor',
})

