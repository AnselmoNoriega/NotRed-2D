project "Sandbox"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++20"
	staticruntime "off"

	targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
	objdir ("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"src/**.h",
		"src/**.cpp"
	}

	includedirs
	{
		"%{wks.location}/NotRed/vendor/spdlog/include",
		"%{wks.location}/NotRed/src",
		"%{wks.location}/NotRed/vendor",
		"%{IncludeDir.Glm}",
		"%{IncludeDir.Entt}"
	}

	links
	{
		"NotRed"
	}

	filter "system:windows"
		systemversion "latest"

	filter "configurations:Debug"
		defines "NR_DEBUG"
		runtime "Debug"
		symbols "on"
		
		postbuildcommands
		{
			"{COPYDIR} \"%{LibraryDir.VulkanSDK_DebugDLL}\" \"%{cfg.targetdir}\""
		}

	filter "configurations:Release"
		defines "NR_RELEASE"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "NR_DIST"
		runtime "Release"
		optimize "on"