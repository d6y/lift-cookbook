import sbt._
object PluginDef extends Build {
  lazy val root = Project("plugins", file(".")) dependsOn( 
    pamflet)
  lazy val pamflet = uri("git://github.com/n8han/pamflet-plugin#0.3.0")
}
