CREATE TABLE "users"(
    "id" BIGINT NOT NULL,
    "email" VARCHAR(255) NOT NULL DEFAULT 'not null',
    "phone_number" VARCHAR(20) NOT NULL,
    "password" VARCHAR(255) NOT NULL,
    "role" VARCHAR(255) CHECK
        (
            "role" IN('(' customer '', '' admin '', '' vendor ')')
        ) NOT NULL,
        "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
        "updated_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL
);
ALTER TABLE
    "users" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "users"."phone_number" IS 'UNIQUE, NOT NULL';
COMMENT
ON COLUMN
    "users"."password" IS 'NOT NULL';
COMMENT
ON COLUMN
    "users"."created_at" IS 'DEFAULT CURRENT_TIMESTAMP';
COMMENT
ON COLUMN
    "users"."updated_at" IS 'ON UPDATE CURRENT_TIMESTAMP';
CREATE TABLE "user profile"(
    "id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "first_name" VARCHAR(100) NOT NULL,
    "last_name" VARCHAR(100) NOT NULL,
    "date_of_birth" DATE NOT NULL,
    "gender" VARCHAR(255) CHECK
        ("gender" IN('')) NOT NULL,
        "bio" TEXT NOT NULL,
        "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
        "updated_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL
);
ALTER TABLE
    "user profile" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "user profile"."gender" IS '(''male'', ''female'')';
COMMENT
ON COLUMN
    "user profile"."created_at" IS 'DEFAULT CURRENT_TIMESTAMP';
COMMENT
ON COLUMN
    "user profile"."updated_at" IS 'ON UPDATE CURRENT_TIMESTAMP';
CREATE TABLE "addresses"(
    "id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "title" VARCHAR(50) NOT NULL,
    "phone_number" VARCHAR(20) NOT NULL,
    "street" VARCHAR(255) NOT NULL,
    "city" VARCHAR(100) NOT NULL,
    "country" VARCHAR(100) NOT NULL,
    "state" VARCHAR(100) NOT NULL,
    "zip_code" VARCHAR(20) NOT NULL,
    "is_default" BOOLEAN NOT NULL,
    "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "updated_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL
);
ALTER TABLE
    "addresses" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "addresses"."user_id" IS 'Foreign Key → users(id), NOT NULL	Manzil kimga tegishli';
COMMENT
ON COLUMN
    "addresses"."title" IS 'NOT NULL	''Home'', ''Office'', ''Mom’s House'', ...';
COMMENT
ON COLUMN
    "addresses"."phone_number" IS 'NOT NULL	Yetkazib berish telefoni';
COMMENT
ON COLUMN
    "addresses"."street" IS 'NOT NULL	Ko‘cha va raqam';
COMMENT
ON COLUMN
    "addresses"."city" IS 'NOT NULL	Shahar';
COMMENT
ON COLUMN
    "addresses"."country" IS 'NOT NULL	Mamlakat';
COMMENT
ON COLUMN
    "addresses"."state" IS 'NULLABLE	Viloyat/tuman (ixtiyoriy)';
COMMENT
ON COLUMN
    "addresses"."zip_code" IS 'NULLABLE	Pochta indeksi';
COMMENT
ON COLUMN
    "addresses"."is_default" IS 'DEFAULT FALSE	Default manzilmi yoki yo‘q';
COMMENT
ON COLUMN
    "addresses"."created_at" IS 'DEFAULT CURRENT_TIMESTAMP';
COMMENT
ON COLUMN
    "addresses"."updated_at" IS 'ON UPDATE CURRENT_TIMESTAMP';
CREATE TABLE "user_cards"(
    "id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "cardholder_name" VARCHAR(100) NOT NULL,
    "card_last4" VARCHAR(4) NOT NULL,
    "expiry_month" VARCHAR(2) NOT NULL,
    "expiry_year" VARCHAR(4) NOT NULL,
    "card_brand" VARCHAR(20) NOT NULL,
    "card_token" VARCHAR(255) NOT NULL,
    "is_default" BOOLEAN NOT NULL,
    "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL
);
ALTER TABLE
    "user_cards" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "user_cards"."user_id" IS 'Foreign Key → users(id), NOT NULL	Kartani kim ishlatadi';
COMMENT
ON COLUMN
    "user_cards"."cardholder_name" IS 'NOT NULL	Karta egasining nomi';
COMMENT
ON COLUMN
    "user_cards"."card_last4" IS 'NOT NULL	Karta raqamining oxirgi 4 raqami (masalan, 4242)';
COMMENT
ON COLUMN
    "user_cards"."expiry_month" IS 'NOT NULL	Karta amal muddati (oy, masalan: ''08'')';
COMMENT
ON COLUMN
    "user_cards"."expiry_year" IS 'NOT NULL	Karta amal muddati (yil, masalan: ''2026'')';
COMMENT
ON COLUMN
    "user_cards"."card_brand" IS 'NULLABLE	Visa, MasterCard, etc.';
COMMENT
ON COLUMN
    "user_cards"."card_token" IS 'NOT NULL, UNIQUE	To‘lov tizimi (Stripe, Click) tomonidan berilgan token';
COMMENT
ON COLUMN
    "user_cards"."is_default" IS 'DEFAULT FALSE	Asosiy to‘lov kartasi';
COMMENT
ON COLUMN
    "user_cards"."created_at" IS 'DEFAULT CURRENT_TIMESTAMP	Qo‘shilgan vaqt';
CREATE TABLE "products"(
    "id" BIGINT NOT NULL,
    "category_id" BIGINT NOT NULL,
    "brand" VARCHAR(100) NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "slug" VARCHAR(255) NOT NULL,
    "description" TEXT NOT NULL,
    "price" DECIMAL(10, 2) NOT NULL,
    "discount_price" DECIMAL(10, 2) NOT NULL,
    "stock" INTEGER NOT NULL,
    "is_active" BOOLEAN NOT NULL,
    "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "updated_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL
);
ALTER TABLE
    "products" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "products"."category_id" IS 'FK → categories(id), NOT NULL	Asosiy kategoriya';
COMMENT
ON COLUMN
    "products"."brand" IS 'NULLABLE	Mahsulot brendi';
COMMENT
ON COLUMN
    "products"."name" IS 'NOT NULL	Mahsulot nomi';
COMMENT
ON COLUMN
    "products"."slug" IS 'UNIQUE	URL friendly nom (seo uchun)';
COMMENT
ON COLUMN
    "products"."description" IS 'NULLABLE	Batafsil tavsif';
COMMENT
ON COLUMN
    "products"."price" IS 'NOT NULL	Asosiy narx';
COMMENT
ON COLUMN
    "products"."discount_price" IS 'NULLABLE	Chegirmali narx (agar mavjud bo‘lsa)';
COMMENT
ON COLUMN
    "products"."stock" IS 'NOT NULL, DEFAULT 0	Ombordagi miqdor';
COMMENT
ON COLUMN
    "products"."is_active" IS 'DEFAULT TRUE	Saytda ko‘rinadimi yo‘qmi';
CREATE TABLE "categories"(
    "id" BIGINT NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "slug" VARCHAR(100) NOT NULL,
    "parent_id" BIGINT NOT NULL,
    "icon" VARCHAR(255) NOT NULL,
    "is_active" BOOLEAN NOT NULL,
    "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "updated_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL
);
ALTER TABLE
    "categories" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "categories"."name" IS 'NOT NULL	Kategoriya nomi';
COMMENT
ON COLUMN
    "categories"."slug" IS 'UNIQUE	SEO uchun (URL friendly nom)';
COMMENT
ON COLUMN
    "categories"."parent_id" IS 'FK → categories(id), NULLABLE	Sub-category bo‘lishi uchun o‘z-o‘ziga bog‘lanish';
COMMENT
ON COLUMN
    "categories"."icon" IS 'NULLABLE	UI uchun ikon (masalan: fa-laptop)';
COMMENT
ON COLUMN
    "categories"."is_active" IS 'DEFAULT TRUE	Ko‘rinadimi yoki yo‘q';
CREATE TABLE "product_variants"(
    "id" BIGINT NOT NULL,
    "product_id" BIGINT NOT NULL,
    "variant_name" VARCHAR(100) NOT NULL,
    "price" DECIMAL(10, 2) NOT NULL,
    "stock" INTEGER NOT NULL,
    "sku" VARCHAR(50) NOT NULL,
    "is_active" BOOLEAN NOT NULL,
    "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "updated_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL
);
ALTER TABLE
    "product_variants" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "product_variants"."product_id" IS 'FK → products(id), NOT NULL	Qaysi mahsulotga tegishli';
COMMENT
ON COLUMN
    "product_variants"."variant_name" IS 'NOT NULL	Variant nomi (masalan: "Red / 128GB")';
COMMENT
ON COLUMN
    "product_variants"."price" IS 'NULLABLE	Agar narxi asosiy mahsulotdan farq qilsa';
COMMENT
ON COLUMN
    "product_variants"."stock" IS 'DEFAULT 0	Qolgan soni';
COMMENT
ON COLUMN
    "product_variants"."sku" IS 'UNIQUE	Ombor uchun unikal kod';
COMMENT
ON COLUMN
    "product_variants"."is_active" IS 'DEFAULT TRUE	Aktiv yoki yo‘qligi';
CREATE TABLE "product_images"(
    "id" BIGINT NOT NULL,
    "product_id" BIGINT NOT NULL,
    "image_url" VARCHAR(255) NOT NULL,
    "alt_text" VARCHAR(150) NOT NULL,
    "is_main" BOOLEAN NOT NULL,
    "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL
);
ALTER TABLE
    "product_images" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "product_images"."product_id" IS 'FK → products(id), NOT NULL	Qaysi mahsulotga tegishli';
COMMENT
ON COLUMN
    "product_images"."image_url" IS 'NOT NULL	Rasm URL yo‘li';
COMMENT
ON COLUMN
    "product_images"."alt_text" IS 'NULLABLE	Rasm uchun alternativ matn (SEO/Accessibility)';
COMMENT
ON COLUMN
    "product_images"."is_main" IS 'DEFAULT FALSE	Asosiy rasmmi (previewda ko‘rinadigan)';
CREATE TABLE "reviews"(
    "id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "product_id" BIGINT NOT NULL,
    "rating" INTEGER NOT NULL,
    "comment" TEXT NOT NULL,
    "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "is_approved" BOOLEAN NOT NULL
);
ALTER TABLE
    "reviews" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "reviews"."user_id" IS 'FK → users(id), NOT NULL	Kim yozgan';
COMMENT
ON COLUMN
    "reviews"."product_id" IS 'FK → products(id), NOT NULL	Qaysi mahsulot haqida';
COMMENT
ON COLUMN
    "reviews"."rating" IS 'NOT NULL, CHECK (rating BETWEEN 1 AND 5)	1 dan 5 gacha yulduz';
COMMENT
ON COLUMN
    "reviews"."comment" IS 'NULLABLE	Izoh matni';
COMMENT
ON COLUMN
    "reviews"."created_at" IS 'DEFAULT CURRENT_TIMESTAMP	Fikr yozilgan vaqt';
COMMENT
ON COLUMN
    "reviews"."is_approved" IS 'DEFAULT FALSE	Moderator tomonidan tasdiqlanganmi';
CREATE TABLE "saved_products"(
    "id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "product_id" BIGINT NOT NULL,
    "saved_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "unique_user_product" BIGINT NOT NULL
);
ALTER TABLE
    "saved_products" ADD PRIMARY KEY("id");
ALTER TABLE
    "saved_products" ADD CONSTRAINT "saved_products_unique_user_product_unique" UNIQUE("unique_user_product");
COMMENT
ON COLUMN
    "saved_products"."user_id" IS 'FK → users(id), NOT NULL	Kim saqladi';
COMMENT
ON COLUMN
    "saved_products"."product_id" IS 'FK → products(id), NOT NULL	Qaysi mahsulot saqlandi';
COMMENT
ON COLUMN
    "saved_products"."saved_at" IS 'DEFAULT CURRENT_TIMESTAMP	Qachon saqlangan';
CREATE TABLE "orders"(
    "id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "status" VARCHAR(20) NOT NULL,
    "total_price" BIGINT NOT NULL,
    "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "updated_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "notes" TEXT NOT NULL
);
ALTER TABLE
    "orders" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "orders"."user_id" IS 'FK → users(id), NOT NULL	Buyurtma qilgan foydalanuvchi';
COMMENT
ON COLUMN
    "orders"."status" IS 'DEFAULT ''pending''	Buyurtma holati (enum sifatida ishlatiladi)';
COMMENT
ON COLUMN
    "orders"."total_price" IS 'NOT NULL	Umumiy narx (chegirma, soliqdan keyin)';
COMMENT
ON COLUMN
    "orders"."created_at" IS 'DEFAULT CURRENT_TIMESTAMP	Buyurtma yaratilgan vaqt';
COMMENT
ON COLUMN
    "orders"."updated_at" IS 'ON UPDATE CURRENT_TIMESTAMP	Oxirgi o‘zgartirilgan vaqt';
COMMENT
ON COLUMN
    "orders"."notes" IS 'NULLABLE	Buyurtmachi izohi, optional';
CREATE TABLE "order_items"(
    "id" BIGINT NOT NULL,
    "order_id" BIGINT NOT NULL,
    "product_id" BIGINT NOT NULL,
    "product_name" VARCHAR(255) NOT NULL,
    "quantity" INTEGER NOT NULL,
    "price" DECIMAL(10, 2) NOT NULL,
    "total" DECIMAL(10, 2) NOT NULL
);
ALTER TABLE
    "order_items" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "order_items"."order_id" IS 'FK → orders(id), NOT NULL	Qaysi buyurtmaga tegishli';
COMMENT
ON COLUMN
    "order_items"."product_id" IS 'FK → products(id), NOT NULL	Qaysi mahsulot';
COMMENT
ON COLUMN
    "order_items"."product_name" IS 'NOT NULL	Buyurtma vaqtidagi mahsulot nomi (history uchun)';
COMMENT
ON COLUMN
    "order_items"."quantity" IS 'NOT NULL, CHECK(quantity > 0)	Nechta dona buyurtma qilingan';
COMMENT
ON COLUMN
    "order_items"."price" IS 'NOT NULL	Har bir mahsulot uchun narx (buyurtma vaqtidagi)';
COMMENT
ON COLUMN
    "order_items"."total" IS 'NOT NULL (calculated: price × quantity)';
CREATE TABLE "delivery"(
    "id" BIGINT NOT NULL,
    "order_id" BIGINT NOT NULL,
    "address_id" BIGINT NOT NULL,
    "delivery_date" DATE NOT NULL,
    "status" VARCHAR(20) NOT NULL,
    "tracking_code" VARCHAR(100) NOT NULL,
    "carrier_name" VARCHAR(100) NOT NULL,
    "notes" TEXT NOT NULL
);
ALTER TABLE
    "delivery" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "delivery"."order_id" IS 'FK → orders(id), UNIQUE, NOT NULL	Qaysi buyurtmaga tegishli (1-to-1)';
COMMENT
ON COLUMN
    "delivery"."address_id" IS 'FK → addresses(id), NOT NULL	Yetkazib berish manzili';
COMMENT
ON COLUMN
    "delivery"."delivery_date" IS 'NULLABLE	Rejalashtirilgan yoki haqiqiy yetkazilgan sana';
COMMENT
ON COLUMN
    "delivery"."status" IS 'DEFAULT ''pending''	Holati (enum: pending, shipped, delivered, failed)';
COMMENT
ON COLUMN
    "delivery"."tracking_code" IS 'NULLABLE	Kuryer/pochta tracking raqami';
COMMENT
ON COLUMN
    "delivery"."carrier_name" IS 'NULLABLE	Masalan, "FedEx", "UzPost"';
COMMENT
ON COLUMN
    "delivery"."notes" IS 'NULLABLE	Qo‘shimcha izohlar (ixtiyoriy)';
CREATE TABLE "transactions"(
    "id" BIGINT NOT NULL,
    "order_id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "card_id" BIGINT NOT NULL,
    "payment_method" VARCHAR(50) NOT NULL,
    "transaction_reference" BIGINT NOT NULL,
    "amount" DECIMAL(10, 2) NOT NULL,
    "status" VARCHAR(20) NOT NULL,
    "paid_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL
);
ALTER TABLE
    "transactions" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "transactions"."order_id" IS 'FK → orders(id), NOT NULL	Qaysi buyurtmaga to‘lov';
COMMENT
ON COLUMN
    "transactions"."user_id" IS 'FK → users(id), NOT NULL	Kim to‘lagan';
COMMENT
ON COLUMN
    "transactions"."payment_method" IS 'NOT NULL	Masalan: card, click, payme, cash';
COMMENT
ON COLUMN
    "transactions"."transaction_reference" IS 'NULLABLE / UNIQUE	To‘lov tizimi tomonidan berilgan ID';
COMMENT
ON COLUMN
    "transactions"."amount" IS 'NOT NULL	To‘langan summa';
COMMENT
ON COLUMN
    "transactions"."status" IS 'DEFAULT ''pending''	enum: pending, success, failed';
COMMENT
ON COLUMN
    "transactions"."paid_at" IS 'NULLABLE	To‘lov qilingan vaqt';
CREATE TABLE "refund_requests"(
    "id" BIGINT NOT NULL,
    "order_item_id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "reason" TEXT NOT NULL,
    "status" VARCHAR(20) NOT NULL,
    "requested_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "processed_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL
);
ALTER TABLE
    "refund_requests" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "refund_requests"."order_item_id" IS 'FK → order_items(id) (qaysi mahsulotga)';
COMMENT
ON COLUMN
    "refund_requests"."user_id" IS 'FK → users(id) (kim so‘rayapti)';
COMMENT
ON COLUMN
    "refund_requests"."reason" IS 'Refund sababi';
COMMENT
ON COLUMN
    "refund_requests"."status" IS 'pending, approved, rejected';
COMMENT
ON COLUMN
    "refund_requests"."requested_at" IS 'So‘rov vaqti';
COMMENT
ON COLUMN
    "refund_requests"."processed_at" IS 'Admin qayta ishlagan vaqti (NULL bo''lishi mumkin)';
CREATE TABLE "promotions"(
    "id" BIGINT NOT NULL,
    "code" VARCHAR(50) NOT NULL,
    "description" TEXT NOT NULL,
    "discount_type" VARCHAR(10) NOT NULL,
    "discount_value" DECIMAL(10, 2) NOT NULL,
    "min_order_amount" DECIMAL(10, 2) NOT NULL,
    "start_date" DATE NOT NULL,
    "end_date" DATE NOT NULL,
    "usage_limit" INTEGER NOT NULL,
    "used_count" INTEGER NOT NULL,
    "is_active" BOOLEAN NOT NULL,
    "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL
);
ALTER TABLE
    "promotions" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "promotions"."code" IS 'Promo code (masalan: SUMMER20)';
COMMENT
ON COLUMN
    "promotions"."description" IS 'Promokod tavsifi';
COMMENT
ON COLUMN
    "promotions"."discount_type" IS 'amount yoki percentage';
COMMENT
ON COLUMN
    "promotions"."discount_value" IS 'Masalan: 20.00 (so‘m) yoki 15.00 (%)';
COMMENT
ON COLUMN
    "promotions"."min_order_amount" IS 'Chegirma qo‘llanadigan minimal buyurtma qiymati (nullable)';
COMMENT
ON COLUMN
    "promotions"."start_date" IS 'boshlanish sanasi';
COMMENT
ON COLUMN
    "promotions"."end_date" IS 'tugash sanasi';
COMMENT
ON COLUMN
    "promotions"."usage_limit" IS 'Nechta marta ishlatilishi mumkin (nullable)';
COMMENT
ON COLUMN
    "promotions"."used_count" IS 'Hozirgacha ishlatilganlar soni';
COMMENT
ON COLUMN
    "promotions"."is_active" IS 'Chegirma hozirda faolligi';
COMMENT
ON COLUMN
    "promotions"."created_at" IS 'yaratilgan vaqt';
CREATE TABLE "banners"(
    "id" BIGINT NOT NULL,
    "title" VARCHAR(100) NOT NULL,
    "image_url" VARCHAR(255) NOT NULL,
    "link_url" VARCHAR(255) NOT NULL,
    "position" BIGINT NOT NULL,
    "is_active" BOOLEAN NOT NULL,
    "start_date" DATE NOT NULL,
    "end_date" DATE NOT NULL,
    "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL
);
ALTER TABLE
    "banners" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "banners"."title" IS 'Banner sarlavhasi';
COMMENT
ON COLUMN
    "banners"."image_url" IS 'Banner rasmi (yoki fayl yo‘li)';
COMMENT
ON COLUMN
    "banners"."link_url" IS 'Bosilganda yo‘naltiriladigan havola';
COMMENT
ON COLUMN
    "banners"."position" IS 'top, middle, bottom, sidebar, va h.k.';
COMMENT
ON COLUMN
    "banners"."is_active" IS 'Banner hozirda ko‘rinadimi';
COMMENT
ON COLUMN
    "banners"."start_date" IS 'Banner boshlanish sanasi';
COMMENT
ON COLUMN
    "banners"."end_date" IS 'Banner tugash sanasi';
COMMENT
ON COLUMN
    "banners"."created_at" IS 'Yaratilgan vaqt';
CREATE TABLE "stories"(
    "id" BIGINT NOT NULL,
    "title" VARCHAR(100) NOT NULL,
    "media_url" VARCHAR(255) NOT NULL,
    "link_url" VARCHAR(255) NOT NULL,
    "is_active" BOOLEAN NOT NULL,
    "start_date" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "end_date" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL
);
ALTER TABLE
    "stories" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "stories"."title" IS 'Story sarlavhasi';
COMMENT
ON COLUMN
    "stories"."media_url" IS 'Rasm yoki video fayl yo‘li';
COMMENT
ON COLUMN
    "stories"."link_url" IS 'Story bosilganda yo‘naltiriladigan URL (nullable)';
COMMENT
ON COLUMN
    "stories"."is_active" IS 'Hozirda ko‘rinadimi';
COMMENT
ON COLUMN
    "stories"."start_date" IS 'Qachondan ko‘rsatiladi';
COMMENT
ON COLUMN
    "stories"."end_date" IS 'Qachongacha ko‘rsatiladi';
COMMENT
ON COLUMN
    "stories"."created_at" IS 'Yaratilgan vaqti';
CREATE TABLE "story_views"(
    "id" BIGINT NOT NULL,
    "story_id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "viewed_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL
);
ALTER TABLE
    "story_views" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "story_views"."story_id" IS 'FK → stories(id)';
COMMENT
ON COLUMN
    "story_views"."user_id" IS 'FK → users(id)';
COMMENT
ON COLUMN
    "story_views"."viewed_at" IS 'Qachon ko‘rildi';
CREATE TABLE "site_settings"(
    "id" BIGINT NOT NULL,
    "key" VARCHAR(100) NOT NULL,
    "value" TEXT NOT NULL,
    "is_active" BOOLEAN NOT NULL,
    "updated_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL
);
ALTER TABLE
    "site_settings" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "site_settings"."key" IS 'Sozlama nomi (masalan: site_name, support_email)';
COMMENT
ON COLUMN
    "site_settings"."value" IS 'Sozlama qiymati';
COMMENT
ON COLUMN
    "site_settings"."is_active" IS 'Ushbu sozlama faolligini bildiradi';
COMMENT
ON COLUMN
    "site_settings"."updated_at" IS 'So‘nggi o‘zgarish vaqti';
CREATE TABLE "cart_items"(
    "id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "product_id" BIGINT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "added_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL
);
ALTER TABLE
    "cart_items" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "cart_items"."user_id" IS 'FK → users(id) – Savat kimga tegishli';
COMMENT
ON COLUMN
    "cart_items"."product_id" IS 'FK → products(id) – Qaysi mahsulot savatda';
COMMENT
ON COLUMN
    "cart_items"."quantity" IS 'Mahsulot miqdori';
COMMENT
ON COLUMN
    "cart_items"."added_at" IS 'Mahsulot savatga qo‘shilgan vaqt';
CREATE TABLE "promotion_products"(
    "id" BIGINT NOT NULL,
    "product_id" BIGINT NOT NULL,
    "promotion_id" BIGINT NOT NULL
);
ALTER TABLE
    "promotion_products" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "promotion_products"."product_id" IS 'FK → promotions(id), NOT NULL';
COMMENT
ON COLUMN
    "promotion_products"."promotion_id" IS 'FK → promotions(id), NOT NULL';
ALTER TABLE
    "story_views" ADD CONSTRAINT "story_views_story_id_foreign" FOREIGN KEY("story_id") REFERENCES "stories"("id");
ALTER TABLE
    "transactions" ADD CONSTRAINT "transactions_order_id_foreign" FOREIGN KEY("order_id") REFERENCES "orders"("id");
ALTER TABLE
    "cart_items" ADD CONSTRAINT "cart_items_product_id_foreign" FOREIGN KEY("product_id") REFERENCES "products"("id");
ALTER TABLE
    "addresses" ADD CONSTRAINT "addresses_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");
ALTER TABLE
    "promotion_products" ADD CONSTRAINT "promotion_products_promotion_id_foreign" FOREIGN KEY("promotion_id") REFERENCES "promotions"("id");
ALTER TABLE
    "cart_items" ADD CONSTRAINT "cart_items_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");
ALTER TABLE
    "delivery" ADD CONSTRAINT "delivery_address_id_foreign" FOREIGN KEY("address_id") REFERENCES "addresses"("id");
ALTER TABLE
    "reviews" ADD CONSTRAINT "reviews_product_id_foreign" FOREIGN KEY("product_id") REFERENCES "products"("id");
ALTER TABLE
    "promotion_products" ADD CONSTRAINT "promotion_products_product_id_foreign" FOREIGN KEY("product_id") REFERENCES "products"("id");
ALTER TABLE
    "product_variants" ADD CONSTRAINT "product_variants_product_id_foreign" FOREIGN KEY("product_id") REFERENCES "products"("id");
ALTER TABLE
    "user profile" ADD CONSTRAINT "user profile_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");
ALTER TABLE
    "transactions" ADD CONSTRAINT "transactions_card_id_foreign" FOREIGN KEY("card_id") REFERENCES "user_cards"("id");
ALTER TABLE
    "product_images" ADD CONSTRAINT "product_images_product_id_foreign" FOREIGN KEY("product_id") REFERENCES "product_variants"("id");
ALTER TABLE
    "reviews" ADD CONSTRAINT "reviews_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");
ALTER TABLE
    "order_items" ADD CONSTRAINT "order_items_order_id_foreign" FOREIGN KEY("order_id") REFERENCES "orders"("id");
ALTER TABLE
    "products" ADD CONSTRAINT "products_category_id_foreign" FOREIGN KEY("category_id") REFERENCES "categories"("id");
ALTER TABLE
    "refund_requests" ADD CONSTRAINT "refund_requests_order_item_id_foreign" FOREIGN KEY("order_item_id") REFERENCES "order_items"("order_id");
ALTER TABLE
    "user_cards" ADD CONSTRAINT "user_cards_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");
ALTER TABLE
    "orders" ADD CONSTRAINT "orders_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");
ALTER TABLE
    "refund_requests" ADD CONSTRAINT "refund_requests_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");
ALTER TABLE
    "delivery" ADD CONSTRAINT "delivery_order_id_foreign" FOREIGN KEY("order_id") REFERENCES "orders"("id");
ALTER TABLE
    "saved_products" ADD CONSTRAINT "saved_products_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");
ALTER TABLE
    "order_items" ADD CONSTRAINT "order_items_product_id_foreign" FOREIGN KEY("product_id") REFERENCES "products"("id");
ALTER TABLE
    "story_views" ADD CONSTRAINT "story_views_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");
ALTER TABLE
    "saved_products" ADD CONSTRAINT "saved_products_product_id_foreign" FOREIGN KEY("product_id") REFERENCES "products"("id");