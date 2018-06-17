# Custom formula to install version 2.1 of Flite on OS X
class Flite < Formula
  desc "Flite: a small run-time speech synthesis engine"
  homepage "http://cmuflite.org/"
  url "https://github.com/festvox/flite/archive/d673f65b2c4a8cd3da7447079309a6dc4bcf1a5e.tar.gz"
  version "2.1"
  sha256 "de21d73bfcfcb913e62804e5b0081a76a38b5d9ed782734be918b26d20950cba"

  patch :p0, :DATA

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "get_voices"
    system "make", "install"
    Dir.chdir("testsuite")
    system "make", "lex_lookup"
    Dir.chdir("..")
    bin.install "./bin/t2p"
    bin.install "./testsuite/lex_lookup"
  end

  test do
    system bin/"flite", "--version"
    system bin/"lex_lookup"
  end
end

__END__
diff --git a/main/Makefile b/main/Makefile
index 1da18a8..64e5fc1 100644
--- ./main/Makefile
+++ ./main/Makefile
@@ -152,8 +152,8 @@ install:
 	done
 	$(INSTALL) -m 755 $(BINDIR)/flite_time $(DESTDIR)$(INSTALLBINDIR)
 #       The libraries: static and shared (if built)
-	cp -pd $(flite_LIBS_deps) $(DESTDIR)$(INSTALLLIBDIR)
+	cp -p $(flite_LIBS_deps) $(DESTDIR)$(INSTALLLIBDIR)
 ifdef SHFLAGS
-	cp -pd $(SHAREDLIBS) $(VERSIONSHAREDLIBS) $(DESTDIR)$(INSTALLLIBDIR)
+	cp -p $(SHAREDLIBS) $(VERSIONSHAREDLIBS) $(DESTDIR)$(INSTALLLIBDIR)
 endif
 

