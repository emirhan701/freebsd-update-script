#!/bin/sh

# Root kullanıcı kontrolü
if [ "$(id -u)" -ne 0 ]; then
    echo "Bu script'i root olarak çalıştırmalısınız! (sudo ./update_freebsd.sh)"
    exit 1
fi

echo "FreeBSD sistem güncelleme işlemi başlatılıyor..."

# FreeBSD sistem güncellemelerini indir ve uygula
freebsd-update fetch install

# Paketleri güncelle
pkg update -f && pkg upgrade -y

echo "Tüm güncellemeler tamamlandı."

# Kullanıcıya yeniden başlatma isteyip istemediğini sor
echo -n "Sistemi yeniden başlatmak istiyor musunuz? (y/n): "
read reboot_choice

if [ "$reboot_choice" = "y" ] || [ "$reboot_choice" = "Y" ]; then
    echo "Sistem yeniden başlatılıyor..."
    reboot
else
    echo "Yeniden başlatma iptal edildi."
fi

exit 0  # Programı başarıyla kapat
