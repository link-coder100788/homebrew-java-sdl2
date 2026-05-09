# typed: false
# frozen_string_literal: true

class JavaSdl2 < Formula
  desc "Java SDL2 JNI bindings (Java + native SDL2 bridge)"
  homepage "https://github.com/link-coder100788/python-sdl2"
  url "https://github.com/link-coder100788/python-sdl2/archive/refs/tags/1.2.0.tar.gz"
  sha256 "5c98bb028ed29900c5e772c883e2b292dd8e458ebc597b70a0fe2bdf7ec511c3"
  license "MIT"

  depends_on "cmake" => build
  depends_on "openjdk"
  depends_on "sdl2"
  depends_on "openal-soft"

  def install
    system "cmake", "-S", ".", "build", "-DUSE_HOMEBREW_OPENAL=ON", "-DOpenAL_ROOT=$(brew --prefix openal-soft)"
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
