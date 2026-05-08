# typed: false
# frozen_string_literal: true

class JavaSdl2 < Formula
  desc "Java SDL2 JNI bindings (Java + native SDL2 bridge)"
  homepage "https://github.com/link-coder100788/python-sdl2"
  url "https://github.com/link-coder100788/python-sdl2/archive/refs/tags/1.1.1.tar.gz"
  sha256 "14cbf62702e9ed35506ff086a1b7e3b939ba35552226ae4dd38c3d06a3227fca"
  license "MIT"

  depends_on "cmake" => build
  depends_on "openjdk"
  depends_on "sdl2"

  def install
    system "cmake", "-S", ".", "build"
    system "cmake", "--build", "build", "--target", "jni_headers"
    system "cmake", "--build", "build", "--target", "java_sdl2"
    system "cmake", "--build", "build", "--target", "java_jar"

    lib.install "build/libjava_sdl2.dylib"
    lib.install "build/JavaSDL2.jar"
  end

  def caveats
    <<~EOS
      Java SDL2 bindings installed.
      Add to your environment:
        export CLASSPATH=#{opt_lib}/JavaSDL2.jar:$CLASSPATH
        export JAVA_LIBRARY_PATH=#{opt_lib}
        export DYLD_LIBRARY_PATH=#{opt_lib}:$DYLD_LIBRARY_PATH
      Or run Java like:
        java -Djava.library.path=#{opt_lib} -cp #{opt_lib}/JavaSDL2.jar YourMain
    EOS
  end
end
