vim.api.nvim_create_user_command('CreateUproject', function(opts)
    local version = opts.args or "5.6"
    local lines = {
        '{',
        '    "FileVersion": 3,',
        '    "EngineAssociation": "'..version..'",',
        '    "Category": "",',
        '    "Description": "",',
        '    "Modules": [',
        '        {',
        '            "Name": "",',
        '            "Type": "Runtime",',
        '            "LoadingPhase": "Default"',
        '        }',
        '    ]',
        '}',
  }
  vim.api.nvim_put(lines, 'l', true, true)
end, { nargs = 1 })

vim.api.nvim_create_user_command('CreateTarget', function(opts)
    local name = opts.args or "MyProject"
    local lines = {
        'using UnrealBuildTool;',
        'using System.Collections.Generic;',
        '',
        'public class '..name..'Target : TargetRules ',
        '{',
        '   public '..name..'Target(TargetInfo Target) : base(Target)',
        '   {',
        '       Type = TargetType.Game;',
        '       DefaultBuildSettings = BuildSettingsVersion.V5;',
        '       IncludeOrderVersion = EngineIncludeOrderVersion.Unreal5_6;',
        '       ExtraModuleNames.Add("");',
        '   }',
        '}',
    }
    vim.api.nvim_put(lines, 'l', true, true)
end, { nargs = 1 })

vim.api.nvim_create_user_command('CreateModuleRules', function(opts)
    local name = opts.args or "MyProjectCore"
    local lines = {
        'using UnrealBuildTool;',
        '',
        'public class '..name..' : ModuleRules',
        '{',
        '   public '..name..'(ReadOnlyTargetRules Target) : base(Target)',
        '   {',
        '       PCHUsage = PCHUsageMode.UseExplicitOrSharedPCHs;',
        '',
        '       PublicDependencyModuleNames.AddRange( new string[] { "Core", "CoreUObject", "Engine", "InputCore", "EnhancedInput" });',
        '       PrivateDependencyModuleNames.AddRange( new string[] { } );',
        '   }',
        '}',
    }
    vim.api.nvim_put(lines, 'l', true, true)
end, { nargs = 1 })

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

    local cmd = string.format(
        "%s -mode=GenerateClangDatabase -NoExecCodeGenActions -project=\"%s\" %sEditor Linux Development",
        engine_path, project_path, project_name
    )

    vim.cmd("split | terminal " .. cmd)
end, {
    nargs = 0,
    desc = 'Generate clang compile_commands.json for the .uproject in current dir',
})
