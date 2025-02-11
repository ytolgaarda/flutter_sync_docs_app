# Sync Doc - Flutter First Offline Docs App
Flutter, Supabase, PowerSync ve Riverpod kullanarak geliştirilen bir çevrimdışı (offline) doküman düzenleme uygulamasıdır. Bu proje, kullanıcıların belgeleri çevrimdışı olarak oluşturup düzenlemelerine olanak tanırken, internet bağlantısı sağlandığında tüm veriler Supabase ile senkronize edilir. Proje, verimli bir belge yönetim sistemi geliştirmeyi hedefler.

## Özellikler

Çevrimdışı Destek: Kullanıcılar, internet bağlantısı olmadan belgelerini oluşturabilir ve düzenleyebilirler. Bağlantı sağlandığında, değişiklikler Supabase ile senkronize edilir.
Supabase Entegrasyonu: Supabase kullanılarak kullanıcı doğrulama, veri depolama ve senkronizasyon işlemleri gerçekleştirilir.
PowerSync: Çevrimdışı verilerin çevrimiçi veritabanına senkronize edilmesi için PowerSync kullanılır. Bu sayede internet bağlantısı sağlandığında veriler kaybolmaz.
Riverpod ile Durum Yönetimi: Uygulama, Riverpod ile durum yönetimi gerçekleştirir. Kullanıcı doğrulama durumu, belge verileri ve çevrimdışı senkronizasyon gibi durumlar yönetilir.

## Teknolojiler

Flutter: Mobil uygulama geliştirme için Flutter kullanılmıştır.
Supabase: Backend veritabanı ve kullanıcı yönetimi için Supabase kullanılmıştır.
PowerSync: Çevrimdışı veri senkronizasyonu için PowerSync kullanılmıştır.
Riverpod: Durum yönetimi için Riverpod kullanılmıştır.