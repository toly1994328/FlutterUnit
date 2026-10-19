allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
    if (project.name == "fx_install_plugin") {
        // 旧版安装插件固定使用 API 32，AGP 9 的依赖检查要求跟随应用的编译 SDK。
        project.afterEvaluate {
            val applicationAndroid = project(":app").extensions
                .getByType<com.android.build.gradle.AppExtension>()
            extensions.configure<com.android.build.gradle.LibraryExtension> {
                compileSdkVersion(requireNotNull(applicationAndroid.compileSdkVersion))
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
