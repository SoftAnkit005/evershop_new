toc.dat                                                                                             0000600 0004000 0002000 00000466220 14623344605 0014460 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP   !                    |            evershop    14.12    16.3 �   �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false         �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false         �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false         �           1262    18190    evershop    DATABASE     {   CREATE DATABASE evershop WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_India.1252';
    DROP DATABASE evershop;
                postgres    false                     2615    2200    public    SCHEMA     2   -- *not* creating schema, since initdb creates it
 2   -- *not* dropping schema, since initdb creates it
                postgres    false         �           0    0    SCHEMA public    ACL     Q   REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;
                   postgres    false    4         (           1255    18191    add_category_created_event()    FUNCTION     �   CREATE FUNCTION public.add_category_created_event() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      INSERT INTO event (name, data)
      VALUES ('category_created', row_to_json(NEW));
      RETURN NEW;
    END;
    $$;
 3   DROP FUNCTION public.add_category_created_event();
       public          postgres    false    4         )           1255    18192    add_category_deleted_event()    FUNCTION     �   CREATE FUNCTION public.add_category_deleted_event() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      INSERT INTO event (name, data)
      VALUES ('category_deleted', row_to_json(OLD));
      RETURN OLD;
    END;
    $$;
 3   DROP FUNCTION public.add_category_deleted_event();
       public          postgres    false    4         *           1255    18193    add_category_updated_event()    FUNCTION     �   CREATE FUNCTION public.add_category_updated_event() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      INSERT INTO event (name, data)
      VALUES ('category_updated', row_to_json(NEW));
      RETURN NEW;
    END;
    $$;
 3   DROP FUNCTION public.add_category_updated_event();
       public          postgres    false    4         +           1255    18194    add_customer_created_event()    FUNCTION     �   CREATE FUNCTION public.add_customer_created_event() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      INSERT INTO event (name, data)
      VALUES ('customer_created', row_to_json(NEW));
      RETURN NEW;
    END;
    $$;
 3   DROP FUNCTION public.add_customer_created_event();
       public          postgres    false    4         ,           1255    18195    add_customer_deleted_event()    FUNCTION     �   CREATE FUNCTION public.add_customer_deleted_event() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      INSERT INTO event (name, data)
      VALUES ('customer_deleted', row_to_json(OLD));
      RETURN OLD;
    END;
    $$;
 3   DROP FUNCTION public.add_customer_deleted_event();
       public          postgres    false    4         -           1255    18196    add_customer_updated_event()    FUNCTION     �   CREATE FUNCTION public.add_customer_updated_event() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      INSERT INTO event (name, data)
      VALUES ('customer_updated', row_to_json(NEW));
      RETURN NEW;
    END;
    $$;
 3   DROP FUNCTION public.add_customer_updated_event();
       public          postgres    false    4         .           1255    18197    add_order_created_event()    FUNCTION     �   CREATE FUNCTION public.add_order_created_event() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      INSERT INTO event (name, data)
      VALUES ('order_created', row_to_json(NEW));
      RETURN NEW;
    END;
    $$;
 0   DROP FUNCTION public.add_order_created_event();
       public          postgres    false    4         /           1255    18198    add_product_created_event()    FUNCTION     �   CREATE FUNCTION public.add_product_created_event() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      INSERT INTO event (name, data)
      VALUES ('product_created', row_to_json(NEW));
      RETURN NEW;
    END;
    $$;
 2   DROP FUNCTION public.add_product_created_event();
       public          postgres    false    4         0           1255    18199    add_product_deleted_event()    FUNCTION     �   CREATE FUNCTION public.add_product_deleted_event() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      INSERT INTO event (name, data)
      VALUES ('product_deleted', row_to_json(OLD));
      RETURN OLD;
    END;
    $$;
 2   DROP FUNCTION public.add_product_deleted_event();
       public          postgres    false    4         1           1255    18200 %   add_product_inventory_updated_event()    FUNCTION     '  CREATE FUNCTION public.add_product_inventory_updated_event() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      INSERT INTO event (name, data)
      VALUES ('inventory_updated', json_build_object('old', row_to_json(OLD), 'new', row_to_json(NEW)));
      RETURN NEW;
    END;
    $$;
 <   DROP FUNCTION public.add_product_inventory_updated_event();
       public          postgres    false    4         2           1255    18201    add_product_updated_event()    FUNCTION     �   CREATE FUNCTION public.add_product_updated_event() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      INSERT INTO event (name, data)
      VALUES ('product_updated', row_to_json(NEW));
      RETURN NEW;
    END;
    $$;
 2   DROP FUNCTION public.add_product_updated_event();
       public          postgres    false    4         3           1255    18202    build_url_key()    FUNCTION     i  CREATE FUNCTION public.build_url_key() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
      url_key TEXT;
    BEGIN
      IF(NEW.url_key IS NULL) THEN
        url_key = regexp_replace(NEW.name, '[^a-zA-Z0-9]+', '-', 'g');
        url_key = regexp_replace(url_key, '^-|-$', '', 'g');
        url_key = lower(url_key);
        url_key = url_key || '-' || (SELECT floor(random() * 1000000)::text);
        NEW.url_key = url_key;
      ELSE
        IF (NEW.url_key ~ '[/\#]') THEN
          RAISE EXCEPTION 'Invalid url_key: %', NEW.url_key;
        END IF;
      END IF;
      RETURN NEW;
    END;
    $_$;
 &   DROP FUNCTION public.build_url_key();
       public          postgres    false    4         4           1255    18203 &   delete_product_attribute_value_index()    FUNCTION     g  CREATE FUNCTION public.delete_product_attribute_value_index() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        DELETE FROM "product_attribute_value_index" WHERE "product_attribute_value_index".option_id = OLD.attribute_option_id AND "product_attribute_value_index"."attribute_id" = OLD.attribute_id;
        RETURN OLD;
      END;
      $$;
 =   DROP FUNCTION public.delete_product_attribute_value_index();
       public          postgres    false    4         5           1255    18204    delete_sub_categories()    FUNCTION     I  CREATE FUNCTION public.delete_sub_categories() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      sub_categories RECORD;
    BEGIN
      FOR sub_categories IN
        WITH RECURSIVE sub_categories AS (
          SELECT * FROM category WHERE parent_id = OLD.category_id
          UNION
          SELECT c.* FROM category c
          INNER JOIN sub_categories sc ON c.parent_id = sc.category_id
        ) SELECT * FROM sub_categories
      LOOP
        DELETE FROM category WHERE category_id = sub_categories.category_id;
      END LOOP;
      RETURN OLD;
    END;
    $$;
 .   DROP FUNCTION public.delete_sub_categories();
       public          postgres    false    4         9           1255    18205 3   delete_variant_group_after_attribute_type_changed()    FUNCTION     1  CREATE FUNCTION public.delete_variant_group_after_attribute_type_changed() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        IF (OLD.type = 'select' AND NEW.type <> 'select') THEN
          DELETE FROM "variant_group" WHERE ("variant_group".attribute_one = OLD.attribute_id OR "variant_group".attribute_two = OLD.attribute_id OR "variant_group".attribute_three = OLD.attribute_id OR "variant_group".attribute_four = OLD.attribute_id OR "variant_group".attribute_five = OLD.attribute_id);
        END IF;
        RETURN NEW;
      END
      $$;
 J   DROP FUNCTION public.delete_variant_group_after_attribute_type_changed();
       public          postgres    false    4         :           1255    18206     prevent_change_attribute_group()    FUNCTION     R  CREATE FUNCTION public.prevent_change_attribute_group() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        IF OLD.group_id != NEW.group_id AND OLD.variant_group_id IS NOT NULL THEN
          RAISE EXCEPTION 'Cannot change attribute group of product with variants';
        END IF;
        RETURN NEW;
      END;
      $$;
 7   DROP FUNCTION public.prevent_change_attribute_group();
       public          postgres    false    4         ;           1255    18207 (   prevent_delete_default_attribute_group()    FUNCTION     "  CREATE FUNCTION public.prevent_delete_default_attribute_group() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        IF OLD.attribute_group_id = 1 THEN
          RAISE EXCEPTION 'Cannot delete default attribute group';
        END IF;
        RETURN OLD;
      END;
      $$;
 ?   DROP FUNCTION public.prevent_delete_default_attribute_group();
       public          postgres    false    4         <           1255    18208 '   prevent_delete_default_customer_group()    FUNCTION       CREATE FUNCTION public.prevent_delete_default_customer_group() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        IF OLD.customer_group_id = 1 THEN
          RAISE EXCEPTION 'Cannot delete default customer group';
        END IF;
        RETURN OLD;
      END;
      $$;
 >   DROP FUNCTION public.prevent_delete_default_customer_group();
       public          postgres    false    4         C           1255    18209 "   prevent_delete_default_tax_class()    FUNCTION       CREATE FUNCTION public.prevent_delete_default_tax_class() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        IF OLD.tax_class_id = 1 THEN
          RAISE EXCEPTION 'Cannot delete default tax class';
        END IF;
        RETURN OLD;
      END;
      $$;
 9   DROP FUNCTION public.prevent_delete_default_tax_class();
       public          postgres    false    4         F           1255    18210    product_image_insert_trigger()    FUNCTION     �   CREATE FUNCTION public.product_image_insert_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        INSERT INTO event (name, data)
        VALUES ('product_image_added', row_to_json(NEW));
        RETURN NEW;
      END;
      $$;
 5   DROP FUNCTION public.product_image_insert_trigger();
       public          postgres    false    4         G           1255    18211 (   reduce_product_stock_when_order_placed()    FUNCTION     )  CREATE FUNCTION public.reduce_product_stock_when_order_placed() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        UPDATE product_inventory SET qty = qty - NEW.qty WHERE product_inventory_product_id = NEW.product_id AND manage_stock = TRUE;
        RETURN NEW;
      END
      $$;
 ?   DROP FUNCTION public.reduce_product_stock_when_order_placed();
       public          postgres    false    4         H           1255    18212    remove_attribute_from_group()    FUNCTION     �  CREATE FUNCTION public.remove_attribute_from_group() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        DELETE FROM product_attribute_value_index WHERE product_attribute_value_index.attribute_id = OLD.attribute_id AND product_attribute_value_index.product_id IN (SELECT product.product_id FROM product WHERE product.group_id = OLD.group_id);
        DELETE FROM variant_group WHERE variant_group.attribute_group_id = OLD.group_id AND (variant_group.attribute_one = OLD.attribute_id OR variant_group.attribute_two = OLD.attribute_id OR variant_group.attribute_three = OLD.attribute_id OR variant_group.attribute_four = OLD.attribute_id OR variant_group.attribute_five = OLD.attribute_id);
        RETURN OLD;
      END;
      $$;
 4   DROP FUNCTION public.remove_attribute_from_group();
       public          postgres    false    4         I           1255    18213    set_coupon_used_time()    FUNCTION     �   CREATE FUNCTION public.set_coupon_used_time() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        UPDATE "coupon" SET used_time = used_time + 1 WHERE coupon = NEW.coupon;
        RETURN NEW;
      END;
      $$;
 -   DROP FUNCTION public.set_coupon_used_time();
       public          postgres    false    4         J           1255    18214    set_default_customer_group()    FUNCTION     �   CREATE FUNCTION public.set_default_customer_group() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        IF NEW.group_id IS NULL THEN
          NEW.group_id = 1;
        END IF;
        RETURN NEW;
      END;
      $$;
 3   DROP FUNCTION public.set_default_customer_group();
       public          postgres    false    4         K           1255    18215 5   update_attribute_index_and_variant_group_visibility()    FUNCTION     #  CREATE FUNCTION public.update_attribute_index_and_variant_group_visibility() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        DELETE FROM "product_attribute_value_index"
        WHERE "product_attribute_value_index"."product_id" = NEW.product_id 
        AND "product_attribute_value_index"."attribute_id" NOT IN (SELECT "attribute_group_link"."attribute_id" FROM "attribute_group_link" WHERE "attribute_group_link"."group_id" = NEW.group_id);
        UPDATE "variant_group" SET visibility = COALESCE((SELECT bool_or(visibility) FROM "product" WHERE "product"."variant_group_id" = NEW.variant_group_id AND "product"."status" = TRUE GROUP BY "product"."variant_group_id"), FALSE) WHERE "variant_group"."variant_group_id" = NEW.variant_group_id;
        RETURN NEW;
      END;
      $$;
 L   DROP FUNCTION public.update_attribute_index_and_variant_group_visibility();
       public          postgres    false    4         L           1255    18216 ,   update_product_attribute_option_value_text()    FUNCTION     �  CREATE FUNCTION public.update_product_attribute_option_value_text() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        UPDATE "product_attribute_value_index" SET "option_text" = NEW.option_text
        WHERE "product_attribute_value_index".option_id = NEW.attribute_option_id AND "product_attribute_value_index".attribute_id = NEW.attribute_id;
        RETURN NEW;
      END;
      $$;
 C   DROP FUNCTION public.update_product_attribute_option_value_text();
       public          postgres    false    4         M           1255    18217 !   update_variant_group_visibility()    FUNCTION     �  CREATE FUNCTION public.update_variant_group_visibility() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        UPDATE "variant_group" SET visibility = (SELECT bool_or(visibility) FROM "product" WHERE "product"."variant_group_id" = NEW.variant_group_id AND "product"."status" = TRUE) WHERE "variant_group"."variant_group_id" = NEW.variant_group_id;
        RETURN NEW;
      END;
      $$;
 8   DROP FUNCTION public.update_variant_group_visibility();
       public          postgres    false    4         �            1259    18218 
   admin_user    TABLE     �  CREATE TABLE public.admin_user (
    admin_user_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    status boolean DEFAULT true NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    full_name character varying,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.admin_user;
       public         heap    postgres    false    4         �            1259    18227    admin_user_admin_user_id_seq    SEQUENCE     �   ALTER TABLE public.admin_user ALTER COLUMN admin_user_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.admin_user_admin_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    4    209         �            1259    18228 	   attribute    TABLE     �  CREATE TABLE public.attribute (
    attribute_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    attribute_code character varying NOT NULL,
    attribute_name character varying NOT NULL,
    type character varying NOT NULL,
    is_required boolean DEFAULT false NOT NULL,
    display_on_frontend boolean DEFAULT false NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    is_filterable boolean DEFAULT false NOT NULL
);
    DROP TABLE public.attribute;
       public         heap    postgres    false    4         �            1259    18238    attribute_attribute_id_seq    SEQUENCE     �   ALTER TABLE public.attribute ALTER COLUMN attribute_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.attribute_attribute_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    4    211         �            1259    18239    attribute_group    TABLE     '  CREATE TABLE public.attribute_group (
    attribute_group_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    group_name text NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
 #   DROP TABLE public.attribute_group;
       public         heap    postgres    false    4         �            1259    18247 &   attribute_group_attribute_group_id_seq    SEQUENCE     �   ALTER TABLE public.attribute_group ALTER COLUMN attribute_group_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.attribute_group_attribute_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    4    213         �            1259    18248    attribute_group_link    TABLE     �   CREATE TABLE public.attribute_group_link (
    attribute_group_link_id integer NOT NULL,
    attribute_id integer NOT NULL,
    group_id integer NOT NULL
);
 (   DROP TABLE public.attribute_group_link;
       public         heap    postgres    false    4         �            1259    18251 0   attribute_group_link_attribute_group_link_id_seq    SEQUENCE       ALTER TABLE public.attribute_group_link ALTER COLUMN attribute_group_link_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.attribute_group_link_attribute_group_link_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    215    4         �            1259    18252    attribute_option    TABLE       CREATE TABLE public.attribute_option (
    attribute_option_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    attribute_id integer NOT NULL,
    attribute_code character varying NOT NULL,
    option_text character varying NOT NULL
);
 $   DROP TABLE public.attribute_option;
       public         heap    postgres    false    4         �            1259    18258 (   attribute_option_attribute_option_id_seq    SEQUENCE     �   ALTER TABLE public.attribute_option ALTER COLUMN attribute_option_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.attribute_option_attribute_option_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    217    4         �            1259    18259    cart    TABLE     �  CREATE TABLE public.cart (
    cart_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    sid character varying,
    currency character varying NOT NULL,
    customer_id integer,
    customer_group_id smallint,
    customer_email character varying,
    customer_full_name character varying,
    user_ip character varying,
    status boolean DEFAULT false NOT NULL,
    coupon character varying,
    shipping_fee_excl_tax numeric(12,4) DEFAULT NULL::numeric,
    shipping_fee_incl_tax numeric(12,4) DEFAULT NULL::numeric,
    discount_amount numeric(12,4) DEFAULT NULL::numeric,
    sub_total numeric(12,4) NOT NULL,
    sub_total_incl_tax numeric(12,4) NOT NULL,
    total_qty integer NOT NULL,
    total_weight numeric(12,4) DEFAULT NULL::numeric,
    tax_amount numeric(12,4) NOT NULL,
    grand_total numeric(12,4) NOT NULL,
    shipping_method character varying,
    shipping_method_name character varying,
    shipping_zone_id integer,
    shipping_address_id integer,
    payment_method character varying,
    payment_method_name character varying,
    billing_address_id integer,
    shipping_note text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.cart;
       public         heap    postgres    false    4         �            1259    18272    cart_address    TABLE     |  CREATE TABLE public.cart_address (
    cart_address_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    full_name character varying,
    postcode character varying,
    telephone character varying,
    country character varying,
    province character varying,
    city character varying,
    address_1 character varying,
    address_2 character varying
);
     DROP TABLE public.cart_address;
       public         heap    postgres    false    4         �            1259    18278     cart_address_cart_address_id_seq    SEQUENCE     �   ALTER TABLE public.cart_address ALTER COLUMN cart_address_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.cart_address_cart_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    4    220         �            1259    18279    cart_cart_id_seq    SEQUENCE     �   ALTER TABLE public.cart ALTER COLUMN cart_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.cart_cart_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    4    219         �            1259    18280 	   cart_item    TABLE     �  CREATE TABLE public.cart_item (
    cart_item_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    cart_id integer NOT NULL,
    product_id integer NOT NULL,
    product_sku character varying NOT NULL,
    product_name text NOT NULL,
    thumbnail character varying,
    product_weight numeric(12,4) DEFAULT NULL::numeric,
    product_price numeric(12,4) NOT NULL,
    product_price_incl_tax numeric(12,4) NOT NULL,
    qty integer NOT NULL,
    final_price numeric(12,4) NOT NULL,
    final_price_incl_tax numeric(12,4) NOT NULL,
    tax_percent numeric(12,4) NOT NULL,
    tax_amount numeric(12,4) NOT NULL,
    discount_amount numeric(12,4) NOT NULL,
    sub_total numeric(12,4) NOT NULL,
    total numeric(12,4) NOT NULL,
    variant_group_id integer,
    variant_options text,
    product_custom_options text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.cart_item;
       public         heap    postgres    false    4         �            1259    18289    cart_item_cart_item_id_seq    SEQUENCE     �   ALTER TABLE public.cart_item ALTER COLUMN cart_item_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.cart_item_cart_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    4    223         �            1259    18290    category    TABLE     m  CREATE TABLE public.category (
    category_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    status boolean NOT NULL,
    parent_id integer,
    include_in_nav boolean NOT NULL,
    "position" smallint,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.category;
       public         heap    postgres    false    4         �            1259    18296    category_category_id_seq    SEQUENCE     �   ALTER TABLE public.category ALTER COLUMN category_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.category_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    4    225         �            1259    18297    category_description    TABLE     v  CREATE TABLE public.category_description (
    category_description_id integer NOT NULL,
    category_description_category_id integer NOT NULL,
    name character varying NOT NULL,
    short_description text,
    description text,
    image character varying,
    meta_title text,
    meta_keywords text,
    meta_description text,
    url_key character varying NOT NULL
);
 (   DROP TABLE public.category_description;
       public         heap    postgres    false    4         �            1259    18302 0   category_description_category_description_id_seq    SEQUENCE       ALTER TABLE public.category_description ALTER COLUMN category_description_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.category_description_category_description_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    227    4         �            1259    18303    cms_page    TABLE     6  CREATE TABLE public.cms_page (
    cms_page_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    layout character varying NOT NULL,
    status boolean,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.cms_page;
       public         heap    postgres    false    4         �            1259    18311    cms_page_cms_page_id_seq    SEQUENCE     �   ALTER TABLE public.cms_page ALTER COLUMN cms_page_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.cms_page_cms_page_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    229    4         �            1259    18312    cms_page_description    TABLE     J  CREATE TABLE public.cms_page_description (
    cms_page_description_id integer NOT NULL,
    cms_page_description_cms_page_id integer,
    url_key character varying NOT NULL,
    name character varying NOT NULL,
    content text,
    meta_title character varying,
    meta_keywords character varying,
    meta_description text
);
 (   DROP TABLE public.cms_page_description;
       public         heap    postgres    false    4         �            1259    18317 0   cms_page_description_cms_page_description_id_seq    SEQUENCE       ALTER TABLE public.cms_page_description ALTER COLUMN cms_page_description_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.cms_page_description_cms_page_description_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    4    231         �            1259    18318 
   collection    TABLE     _  CREATE TABLE public.collection (
    collection_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying NOT NULL,
    description text,
    code character varying NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.collection;
       public         heap    postgres    false    4         �            1259    18326    collection_collection_id_seq    SEQUENCE     �   ALTER TABLE public.collection ALTER COLUMN collection_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.collection_collection_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    4    233         �            1259    18327    coupon    TABLE     &  CREATE TABLE public.coupon (
    coupon_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    status boolean DEFAULT true NOT NULL,
    description character varying NOT NULL,
    discount_amount numeric(12,4) NOT NULL,
    free_shipping boolean DEFAULT false NOT NULL,
    discount_type character varying DEFAULT '1'::character varying NOT NULL,
    coupon character varying NOT NULL,
    used_time integer DEFAULT 0 NOT NULL,
    target_products jsonb,
    condition jsonb,
    user_condition jsonb,
    buyx_gety jsonb,
    max_uses_time_per_coupon integer,
    max_uses_time_per_customer integer,
    start_date timestamp with time zone,
    end_date timestamp with time zone,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "POSITIVE_DISCOUNT_AMOUNT" CHECK ((discount_amount >= (0)::numeric)),
    CONSTRAINT "VALID_PERCENTAGE_DISCOUNT" CHECK (((discount_amount <= (100)::numeric) OR ((discount_type)::text <> 'percentage'::text)))
);
    DROP TABLE public.coupon;
       public         heap    postgres    false    4         �            1259    18341    coupon_coupon_id_seq    SEQUENCE     �   ALTER TABLE public.coupon ALTER COLUMN coupon_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.coupon_coupon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    235    4         �            1259    18342    customer    TABLE     �  CREATE TABLE public.customer (
    customer_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    status smallint DEFAULT 1 NOT NULL,
    group_id integer DEFAULT 1,
    email character varying NOT NULL,
    password character varying NOT NULL,
    full_name character varying,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.customer;
       public         heap    postgres    false    4         �            1259    18352    customer_address    TABLE     N  CREATE TABLE public.customer_address (
    customer_address_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    customer_id integer NOT NULL,
    full_name character varying,
    telephone character varying,
    address_1 character varying,
    address_2 character varying,
    postcode character varying,
    city character varying,
    province character varying,
    country character varying NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    is_default smallint
);
 $   DROP TABLE public.customer_address;
       public         heap    postgres    false    4         �            1259    18360 (   customer_address_customer_address_id_seq    SEQUENCE     �   ALTER TABLE public.customer_address ALTER COLUMN customer_address_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.customer_address_customer_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    4    238         �            1259    18361    customer_customer_id_seq    SEQUENCE     �   ALTER TABLE public.customer ALTER COLUMN customer_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.customer_customer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    4    237         �            1259    18362    customer_group    TABLE     2  CREATE TABLE public.customer_group (
    customer_group_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    group_name character varying NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
 "   DROP TABLE public.customer_group;
       public         heap    postgres    false    4         �            1259    18370 $   customer_group_customer_group_id_seq    SEQUENCE     �   ALTER TABLE public.customer_group ALTER COLUMN customer_group_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.customer_group_customer_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    241    4         �            1259    18371    event    TABLE     �   CREATE TABLE public.event (
    event_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying NOT NULL,
    data json,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.event;
       public         heap    postgres    false    4         �            1259    18378    event_event_id_seq    SEQUENCE     �   ALTER TABLE public.event ALTER COLUMN event_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.event_event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    4    243         �            1259    18379 	   migration    TABLE       CREATE TABLE public.migration (
    migration_id integer NOT NULL,
    module character varying NOT NULL,
    version character varying NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.migration;
       public         heap    postgres    false    4         �            1259    18386    migration_migration_id_seq    SEQUENCE     �   ALTER TABLE public.migration ALTER COLUMN migration_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.migration_migration_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    4    245         �            1259    18387    order    TABLE     u  CREATE TABLE public."order" (
    order_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    integration_order_id character varying,
    sid character varying,
    order_number character varying NOT NULL,
    cart_id integer NOT NULL,
    currency character varying NOT NULL,
    customer_id integer,
    customer_email character varying,
    customer_full_name character varying,
    user_ip character varying,
    user_agent character varying,
    coupon character varying,
    shipping_fee_excl_tax numeric(12,4) DEFAULT NULL::numeric,
    shipping_fee_incl_tax numeric(12,4) DEFAULT NULL::numeric,
    discount_amount numeric(12,4) DEFAULT NULL::numeric,
    sub_total numeric(12,4) NOT NULL,
    sub_total_incl_tax numeric(12,4) NOT NULL,
    total_qty integer NOT NULL,
    total_weight numeric(12,4) DEFAULT NULL::numeric,
    tax_amount numeric(12,4) NOT NULL,
    shipping_note text,
    grand_total numeric(12,4) NOT NULL,
    shipping_method character varying,
    shipping_method_name character varying,
    shipping_address_id integer,
    payment_method character varying,
    payment_method_name character varying,
    billing_address_id integer,
    shipment_status character varying,
    payment_status character varying,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public."order";
       public         heap    postgres    false    4         �            1259    18399    order_activity    TABLE     �  CREATE TABLE public.order_activity (
    order_activity_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    order_activity_order_id integer NOT NULL,
    comment text NOT NULL,
    customer_notified boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
 "   DROP TABLE public.order_activity;
       public         heap    postgres    false    4         �            1259    18408 $   order_activity_order_activity_id_seq    SEQUENCE     �   ALTER TABLE public.order_activity ALTER COLUMN order_activity_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.order_activity_order_activity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    4    248         �            1259    18409    order_address    TABLE     ~  CREATE TABLE public.order_address (
    order_address_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    full_name character varying,
    postcode character varying,
    telephone character varying,
    country character varying,
    province character varying,
    city character varying,
    address_1 character varying,
    address_2 character varying
);
 !   DROP TABLE public.order_address;
       public         heap    postgres    false    4         �            1259    18415 "   order_address_order_address_id_seq    SEQUENCE     �   ALTER TABLE public.order_address ALTER COLUMN order_address_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.order_address_order_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    4    250         �            1259    18416 
   order_item    TABLE     �  CREATE TABLE public.order_item (
    order_item_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    order_item_order_id integer NOT NULL,
    product_id integer NOT NULL,
    referer integer,
    product_sku character varying NOT NULL,
    product_name text NOT NULL,
    thumbnail character varying,
    product_weight numeric(12,4) DEFAULT NULL::numeric,
    product_price numeric(12,4) NOT NULL,
    product_price_incl_tax numeric(12,4) NOT NULL,
    qty integer NOT NULL,
    final_price numeric(12,4) NOT NULL,
    final_price_incl_tax numeric(12,4) NOT NULL,
    tax_percent numeric(12,4) NOT NULL,
    tax_amount numeric(12,4) NOT NULL,
    discount_amount numeric(12,4) NOT NULL,
    sub_total numeric(12,4) NOT NULL,
    total numeric(12,4) NOT NULL,
    variant_group_id integer,
    variant_options text,
    product_custom_options text,
    requested_data text
);
    DROP TABLE public.order_item;
       public         heap    postgres    false    4         �            1259    18423    order_item_order_item_id_seq    SEQUENCE     �   ALTER TABLE public.order_item ALTER COLUMN order_item_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.order_item_order_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    4    252         �            1259    18424    order_order_id_seq    SEQUENCE     �   ALTER TABLE public."order" ALTER COLUMN order_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.order_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    4    247         �            1259    18425    payment_transaction    TABLE     �  CREATE TABLE public.payment_transaction (
    payment_transaction_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    payment_transaction_order_id integer NOT NULL,
    transaction_id character varying,
    transaction_type character varying NOT NULL,
    amount numeric(12,4) NOT NULL,
    parent_transaction_id character varying,
    payment_action character varying,
    additional_information text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
 '   DROP TABLE public.payment_transaction;
       public         heap    postgres    false    4                     1259    18432 .   payment_transaction_payment_transaction_id_seq    SEQUENCE     	  ALTER TABLE public.payment_transaction ALTER COLUMN payment_transaction_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.payment_transaction_payment_transaction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    255    4                    1259    18433    product    TABLE       CREATE TABLE public.product (
    product_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    type character varying DEFAULT 'simple'::character varying NOT NULL,
    variant_group_id integer,
    visibility boolean DEFAULT true NOT NULL,
    group_id integer DEFAULT 1,
    sku character varying NOT NULL,
    price numeric(12,4) NOT NULL,
    weight numeric(12,4) DEFAULT NULL::numeric,
    tax_class smallint,
    status boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    category_id integer,
    brand text,
    powersource text,
    usefor text,
    itemweight text,
    material text,
    color text,
    specialfeature text,
    specificusesforproduct text,
    productbenefits text,
    productdimensions text,
    companydetails text,
    video text,
    CONSTRAINT "UNSIGNED_PRICE" CHECK ((price >= (0)::numeric)),
    CONSTRAINT "UNSIGNED_WEIGHT" CHECK ((weight >= (0)::numeric))
);
    DROP TABLE public.product;
       public         heap    postgres    false    4                    1259    18448    product_attribute_value_index    TABLE     �   CREATE TABLE public.product_attribute_value_index (
    product_attribute_value_index_id integer NOT NULL,
    product_id integer NOT NULL,
    attribute_id integer NOT NULL,
    option_id integer,
    option_text text
);
 1   DROP TABLE public.product_attribute_value_index;
       public         heap    postgres    false    4                    1259    18453 ?   product_attribute_value_index_product_attribute_value_index_seq    SEQUENCE     .  ALTER TABLE public.product_attribute_value_index ALTER COLUMN product_attribute_value_index_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.product_attribute_value_index_product_attribute_value_index_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    4    258                    1259    18454    product_collection    TABLE     �   CREATE TABLE public.product_collection (
    product_collection_id integer NOT NULL,
    collection_id integer NOT NULL,
    product_id integer NOT NULL
);
 &   DROP TABLE public.product_collection;
       public         heap    postgres    false    4                    1259    18457 ,   product_collection_product_collection_id_seq    SEQUENCE       ALTER TABLE public.product_collection ALTER COLUMN product_collection_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.product_collection_product_collection_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    4    260                    1259    18458    product_custom_option    TABLE     f  CREATE TABLE public.product_custom_option (
    product_custom_option_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    product_custom_option_product_id integer NOT NULL,
    option_name character varying NOT NULL,
    option_type character varying NOT NULL,
    is_required boolean DEFAULT false NOT NULL,
    sort_order integer
);
 )   DROP TABLE public.product_custom_option;
       public         heap    postgres    false    4                    1259    18465 2   product_custom_option_product_custom_option_id_seq    SEQUENCE       ALTER TABLE public.product_custom_option ALTER COLUMN product_custom_option_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.product_custom_option_product_custom_option_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    262    4                    1259    18466    product_custom_option_value    TABLE     .  CREATE TABLE public.product_custom_option_value (
    product_custom_option_value_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    option_id integer NOT NULL,
    extra_price numeric(12,4) DEFAULT NULL::numeric,
    sort_order integer,
    value character varying NOT NULL
);
 /   DROP TABLE public.product_custom_option_value;
       public         heap    postgres    false    4         	           1259    18473 >   product_custom_option_value_product_custom_option_value_id_seq    SEQUENCE     )  ALTER TABLE public.product_custom_option_value ALTER COLUMN product_custom_option_value_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.product_custom_option_value_product_custom_option_value_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    4    264         
           1259    18474    product_description    TABLE     U  CREATE TABLE public.product_description (
    product_description_id integer NOT NULL,
    product_description_product_id integer NOT NULL,
    name character varying NOT NULL,
    description text,
    short_description text,
    url_key character varying NOT NULL,
    meta_title text,
    meta_description text,
    meta_keywords text
);
 '   DROP TABLE public.product_description;
       public         heap    postgres    false    4                    1259    18479 .   product_description_product_description_id_seq    SEQUENCE     	  ALTER TABLE public.product_description ALTER COLUMN product_description_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.product_description_product_description_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    266    4                    1259    18480    product_image    TABLE       CREATE TABLE public.product_image (
    product_image_id integer NOT NULL,
    product_image_product_id integer NOT NULL,
    origin_image character varying NOT NULL,
    thumb_image text,
    listing_image text,
    single_image text,
    is_main boolean DEFAULT false
);
 !   DROP TABLE public.product_image;
       public         heap    postgres    false    4                    1259    18486 "   product_image_product_image_id_seq    SEQUENCE     �   ALTER TABLE public.product_image ALTER COLUMN product_image_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.product_image_product_image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    4    268                    1259    18487    product_inventory    TABLE       CREATE TABLE public.product_inventory (
    product_inventory_id integer NOT NULL,
    product_inventory_product_id integer NOT NULL,
    qty integer DEFAULT 0 NOT NULL,
    manage_stock boolean DEFAULT false NOT NULL,
    stock_availability boolean DEFAULT false NOT NULL
);
 %   DROP TABLE public.product_inventory;
       public         heap    postgres    false    4                    1259    18493 *   product_inventory_product_inventory_id_seq    SEQUENCE       ALTER TABLE public.product_inventory ALTER COLUMN product_inventory_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.product_inventory_product_inventory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    4    270                    1259    18494    product_product_id_seq    SEQUENCE     �   ALTER TABLE public.product ALTER COLUMN product_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.product_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    257    4                    1259    18495    reset_password_token    TABLE     �   CREATE TABLE public.reset_password_token (
    reset_password_token_id integer NOT NULL,
    customer_id integer NOT NULL,
    token text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);
 (   DROP TABLE public.reset_password_token;
       public         heap    postgres    false    4                    1259    18501 0   reset_password_token_reset_password_token_id_seq    SEQUENCE       ALTER TABLE public.reset_password_token ALTER COLUMN reset_password_token_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.reset_password_token_reset_password_token_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    4    273                    1259    18502    session    TABLE     �   CREATE TABLE public.session (
    sid character varying NOT NULL,
    sess json NOT NULL,
    expire timestamp(6) without time zone NOT NULL
);
    DROP TABLE public.session;
       public         heap    postgres    false    4                    1259    18507    setting    TABLE     �   CREATE TABLE public.setting (
    setting_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying NOT NULL,
    value text,
    is_json boolean DEFAULT false NOT NULL
);
    DROP TABLE public.setting;
       public         heap    postgres    false    4                    1259    18514    setting_setting_id_seq    SEQUENCE     �   ALTER TABLE public.setting ALTER COLUMN setting_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.setting_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    276    4                    1259    18515    shipment    TABLE     i  CREATE TABLE public.shipment (
    shipment_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    shipment_order_id integer NOT NULL,
    carrier character varying,
    tracking_number character varying,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.shipment;
       public         heap    postgres    false    4                    1259    18523    shipment_shipment_id_seq    SEQUENCE     �   ALTER TABLE public.shipment ALTER COLUMN shipment_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.shipment_shipment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    4    278                    1259    18524    shipping_method    TABLE     �   CREATE TABLE public.shipping_method (
    shipping_method_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying NOT NULL
);
 #   DROP TABLE public.shipping_method;
       public         heap    postgres    false    4                    1259    18530 &   shipping_method_shipping_method_id_seq    SEQUENCE     �   ALTER TABLE public.shipping_method ALTER COLUMN shipping_method_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.shipping_method_shipping_method_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    4    280                    1259    18531    shipping_zone    TABLE     �   CREATE TABLE public.shipping_zone (
    shipping_zone_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying NOT NULL,
    country character varying NOT NULL
);
 !   DROP TABLE public.shipping_zone;
       public         heap    postgres    false    4                    1259    18537    shipping_zone_method    TABLE     �  CREATE TABLE public.shipping_zone_method (
    shipping_zone_method_id integer NOT NULL,
    method_id integer NOT NULL,
    zone_id integer NOT NULL,
    is_enabled boolean DEFAULT true NOT NULL,
    cost numeric(12,4) DEFAULT NULL::numeric,
    calculate_api character varying,
    condition_type character varying,
    max numeric(12,4) DEFAULT NULL::numeric,
    min numeric(12,4) DEFAULT NULL::numeric,
    price_based_cost jsonb,
    weight_based_cost jsonb
);
 (   DROP TABLE public.shipping_zone_method;
       public         heap    postgres    false    4                    1259    18546 0   shipping_zone_method_shipping_zone_method_id_seq    SEQUENCE       ALTER TABLE public.shipping_zone_method ALTER COLUMN shipping_zone_method_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.shipping_zone_method_shipping_zone_method_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    4    283                    1259    18547    shipping_zone_province    TABLE     �   CREATE TABLE public.shipping_zone_province (
    shipping_zone_province_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    zone_id integer NOT NULL,
    province character varying NOT NULL
);
 *   DROP TABLE public.shipping_zone_province;
       public         heap    postgres    false    4                    1259    18553 4   shipping_zone_province_shipping_zone_province_id_seq    SEQUENCE       ALTER TABLE public.shipping_zone_province ALTER COLUMN shipping_zone_province_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.shipping_zone_province_shipping_zone_province_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    4    285                    1259    18554 "   shipping_zone_shipping_zone_id_seq    SEQUENCE     �   ALTER TABLE public.shipping_zone ALTER COLUMN shipping_zone_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.shipping_zone_shipping_zone_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    4    282                     1259    18555 	   tax_class    TABLE     �   CREATE TABLE public.tax_class (
    tax_class_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying NOT NULL
);
    DROP TABLE public.tax_class;
       public         heap    postgres    false    4         !           1259    18561    tax_class_tax_class_id_seq    SEQUENCE     �   ALTER TABLE public.tax_class ALTER COLUMN tax_class_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tax_class_tax_class_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    4    288         "           1259    18562    tax_rate    TABLE     v  CREATE TABLE public.tax_rate (
    tax_rate_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying NOT NULL,
    tax_class_id integer,
    country character varying DEFAULT '*'::character varying NOT NULL,
    province character varying DEFAULT '*'::character varying NOT NULL,
    postcode character varying DEFAULT '*'::character varying NOT NULL,
    rate numeric(12,4) NOT NULL,
    is_compound boolean DEFAULT false NOT NULL,
    priority integer NOT NULL,
    CONSTRAINT "UNSIGNED_PRIORITY" CHECK ((priority >= 0)),
    CONSTRAINT "UNSIGNED_RATE" CHECK ((rate >= (0)::numeric))
);
    DROP TABLE public.tax_rate;
       public         heap    postgres    false    4         #           1259    18574    tax_rate_tax_rate_id_seq    SEQUENCE     �   ALTER TABLE public.tax_rate ALTER COLUMN tax_rate_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tax_rate_tax_rate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    290    4         $           1259    18575    url_rewrite    TABLE     $  CREATE TABLE public.url_rewrite (
    url_rewrite_id integer NOT NULL,
    language character varying DEFAULT 'en'::character varying NOT NULL,
    request_path character varying NOT NULL,
    target_path character varying NOT NULL,
    entity_uuid uuid,
    entity_type character varying
);
    DROP TABLE public.url_rewrite;
       public         heap    postgres    false    4         %           1259    18581    url_rewrite_url_rewrite_id_seq    SEQUENCE     �   ALTER TABLE public.url_rewrite ALTER COLUMN url_rewrite_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.url_rewrite_url_rewrite_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    292    4         &           1259    18582    variant_group    TABLE     b  CREATE TABLE public.variant_group (
    variant_group_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    attribute_group_id integer NOT NULL,
    attribute_one integer,
    attribute_two integer,
    attribute_three integer,
    attribute_four integer,
    attribute_five integer,
    visibility boolean DEFAULT false NOT NULL
);
 !   DROP TABLE public.variant_group;
       public         heap    postgres    false    4         '           1259    18587 "   variant_group_variant_group_id_seq    SEQUENCE     �   ALTER TABLE public.variant_group ALTER COLUMN variant_group_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.variant_group_variant_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    4    294         z          0    18218 
   admin_user 
   TABLE DATA           u   COPY public.admin_user (admin_user_id, uuid, status, email, password, full_name, created_at, updated_at) FROM stdin;
    public          postgres    false    209       3962.dat |          0    18228 	   attribute 
   TABLE DATA           �   COPY public.attribute (attribute_id, uuid, attribute_code, attribute_name, type, is_required, display_on_frontend, sort_order, is_filterable) FROM stdin;
    public          postgres    false    211       3964.dat ~          0    18239    attribute_group 
   TABLE DATA           g   COPY public.attribute_group (attribute_group_id, uuid, group_name, created_at, updated_at) FROM stdin;
    public          postgres    false    213       3966.dat �          0    18248    attribute_group_link 
   TABLE DATA           _   COPY public.attribute_group_link (attribute_group_link_id, attribute_id, group_id) FROM stdin;
    public          postgres    false    215       3968.dat �          0    18252    attribute_option 
   TABLE DATA           p   COPY public.attribute_option (attribute_option_id, uuid, attribute_id, attribute_code, option_text) FROM stdin;
    public          postgres    false    217       3970.dat �          0    18259    cart 
   TABLE DATA           �  COPY public.cart (cart_id, uuid, sid, currency, customer_id, customer_group_id, customer_email, customer_full_name, user_ip, status, coupon, shipping_fee_excl_tax, shipping_fee_incl_tax, discount_amount, sub_total, sub_total_incl_tax, total_qty, total_weight, tax_amount, grand_total, shipping_method, shipping_method_name, shipping_zone_id, shipping_address_id, payment_method, payment_method_name, billing_address_id, shipping_note, created_at, updated_at) FROM stdin;
    public          postgres    false    219       3972.dat �          0    18272    cart_address 
   TABLE DATA           �   COPY public.cart_address (cart_address_id, uuid, full_name, postcode, telephone, country, province, city, address_1, address_2) FROM stdin;
    public          postgres    false    220       3973.dat �          0    18280 	   cart_item 
   TABLE DATA           `  COPY public.cart_item (cart_item_id, uuid, cart_id, product_id, product_sku, product_name, thumbnail, product_weight, product_price, product_price_incl_tax, qty, final_price, final_price_incl_tax, tax_percent, tax_amount, discount_amount, sub_total, total, variant_group_id, variant_options, product_custom_options, created_at, updated_at) FROM stdin;
    public          postgres    false    223       3976.dat �          0    18290    category 
   TABLE DATA           |   COPY public.category (category_id, uuid, status, parent_id, include_in_nav, "position", created_at, updated_at) FROM stdin;
    public          postgres    false    225       3978.dat �          0    18297    category_description 
   TABLE DATA           �   COPY public.category_description (category_description_id, category_description_category_id, name, short_description, description, image, meta_title, meta_keywords, meta_description, url_key) FROM stdin;
    public          postgres    false    227       3980.dat �          0    18303    cms_page 
   TABLE DATA           ]   COPY public.cms_page (cms_page_id, uuid, layout, status, created_at, updated_at) FROM stdin;
    public          postgres    false    229       3982.dat �          0    18312    cms_page_description 
   TABLE DATA           �   COPY public.cms_page_description (cms_page_description_id, cms_page_description_cms_page_id, url_key, name, content, meta_title, meta_keywords, meta_description) FROM stdin;
    public          postgres    false    231       3984.dat �          0    18318 
   collection 
   TABLE DATA           j   COPY public.collection (collection_id, uuid, name, description, code, created_at, updated_at) FROM stdin;
    public          postgres    false    233       3986.dat �          0    18327    coupon 
   TABLE DATA           #  COPY public.coupon (coupon_id, uuid, status, description, discount_amount, free_shipping, discount_type, coupon, used_time, target_products, condition, user_condition, buyx_gety, max_uses_time_per_coupon, max_uses_time_per_customer, start_date, end_date, created_at, updated_at) FROM stdin;
    public          postgres    false    235       3988.dat �          0    18342    customer 
   TABLE DATA           {   COPY public.customer (customer_id, uuid, status, group_id, email, password, full_name, created_at, updated_at) FROM stdin;
    public          postgres    false    237       3990.dat �          0    18352    customer_address 
   TABLE DATA           �   COPY public.customer_address (customer_address_id, uuid, customer_id, full_name, telephone, address_1, address_2, postcode, city, province, country, created_at, updated_at, is_default) FROM stdin;
    public          postgres    false    238       3991.dat �          0    18362    customer_group 
   TABLE DATA           e   COPY public.customer_group (customer_group_id, uuid, group_name, created_at, updated_at) FROM stdin;
    public          postgres    false    241       3994.dat �          0    18371    event 
   TABLE DATA           G   COPY public.event (event_id, uuid, name, data, created_at) FROM stdin;
    public          postgres    false    243       3996.dat �          0    18379 	   migration 
   TABLE DATA           Z   COPY public.migration (migration_id, module, version, created_at, updated_at) FROM stdin;
    public          postgres    false    245       3998.dat �          0    18387    order 
   TABLE DATA             COPY public."order" (order_id, uuid, integration_order_id, sid, order_number, cart_id, currency, customer_id, customer_email, customer_full_name, user_ip, user_agent, coupon, shipping_fee_excl_tax, shipping_fee_incl_tax, discount_amount, sub_total, sub_total_incl_tax, total_qty, total_weight, tax_amount, shipping_note, grand_total, shipping_method, shipping_method_name, shipping_address_id, payment_method, payment_method_name, billing_address_id, shipment_status, payment_status, created_at, updated_at) FROM stdin;
    public          postgres    false    247       4000.dat �          0    18399    order_activity 
   TABLE DATA           �   COPY public.order_activity (order_activity_id, uuid, order_activity_order_id, comment, customer_notified, created_at, updated_at) FROM stdin;
    public          postgres    false    248       4001.dat �          0    18409    order_address 
   TABLE DATA           �   COPY public.order_address (order_address_id, uuid, full_name, postcode, telephone, country, province, city, address_1, address_2) FROM stdin;
    public          postgres    false    250       4003.dat �          0    18416 
   order_item 
   TABLE DATA           o  COPY public.order_item (order_item_id, uuid, order_item_order_id, product_id, referer, product_sku, product_name, thumbnail, product_weight, product_price, product_price_incl_tax, qty, final_price, final_price_incl_tax, tax_percent, tax_amount, discount_amount, sub_total, total, variant_group_id, variant_options, product_custom_options, requested_data) FROM stdin;
    public          postgres    false    252       4005.dat �          0    18425    payment_transaction 
   TABLE DATA           �   COPY public.payment_transaction (payment_transaction_id, uuid, payment_transaction_order_id, transaction_id, transaction_type, amount, parent_transaction_id, payment_action, additional_information, created_at) FROM stdin;
    public          postgres    false    255       4008.dat �          0    18433    product 
   TABLE DATA           I  COPY public.product (product_id, uuid, type, variant_group_id, visibility, group_id, sku, price, weight, tax_class, status, created_at, updated_at, category_id, brand, powersource, usefor, itemweight, material, color, specialfeature, specificusesforproduct, productbenefits, productdimensions, companydetails, video) FROM stdin;
    public          postgres    false    257       4010.dat �          0    18448    product_attribute_value_index 
   TABLE DATA           �   COPY public.product_attribute_value_index (product_attribute_value_index_id, product_id, attribute_id, option_id, option_text) FROM stdin;
    public          postgres    false    258       4011.dat �          0    18454    product_collection 
   TABLE DATA           ^   COPY public.product_collection (product_collection_id, collection_id, product_id) FROM stdin;
    public          postgres    false    260       4013.dat �          0    18458    product_custom_option 
   TABLE DATA           �   COPY public.product_custom_option (product_custom_option_id, uuid, product_custom_option_product_id, option_name, option_type, is_required, sort_order) FROM stdin;
    public          postgres    false    262       4015.dat �          0    18466    product_custom_option_value 
   TABLE DATA           �   COPY public.product_custom_option_value (product_custom_option_value_id, uuid, option_id, extra_price, sort_order, value) FROM stdin;
    public          postgres    false    264       4017.dat �          0    18474    product_description 
   TABLE DATA           �   COPY public.product_description (product_description_id, product_description_product_id, name, description, short_description, url_key, meta_title, meta_description, meta_keywords) FROM stdin;
    public          postgres    false    266       4019.dat �          0    18480    product_image 
   TABLE DATA           �   COPY public.product_image (product_image_id, product_image_product_id, origin_image, thumb_image, listing_image, single_image, is_main) FROM stdin;
    public          postgres    false    268       4021.dat �          0    18487    product_inventory 
   TABLE DATA           �   COPY public.product_inventory (product_inventory_id, product_inventory_product_id, qty, manage_stock, stock_availability) FROM stdin;
    public          postgres    false    270       4023.dat �          0    18495    reset_password_token 
   TABLE DATA           g   COPY public.reset_password_token (reset_password_token_id, customer_id, token, created_at) FROM stdin;
    public          postgres    false    273       4026.dat �          0    18502    session 
   TABLE DATA           4   COPY public.session (sid, sess, expire) FROM stdin;
    public          postgres    false    275       4028.dat �          0    18507    setting 
   TABLE DATA           I   COPY public.setting (setting_id, uuid, name, value, is_json) FROM stdin;
    public          postgres    false    276       4029.dat �          0    18515    shipment 
   TABLE DATA           z   COPY public.shipment (shipment_id, uuid, shipment_order_id, carrier, tracking_number, created_at, updated_at) FROM stdin;
    public          postgres    false    278       4031.dat �          0    18524    shipping_method 
   TABLE DATA           I   COPY public.shipping_method (shipping_method_id, uuid, name) FROM stdin;
    public          postgres    false    280       4033.dat �          0    18531    shipping_zone 
   TABLE DATA           N   COPY public.shipping_zone (shipping_zone_id, uuid, name, country) FROM stdin;
    public          postgres    false    282       4035.dat �          0    18537    shipping_zone_method 
   TABLE DATA           �   COPY public.shipping_zone_method (shipping_zone_method_id, method_id, zone_id, is_enabled, cost, calculate_api, condition_type, max, min, price_based_cost, weight_based_cost) FROM stdin;
    public          postgres    false    283       4036.dat �          0    18547    shipping_zone_province 
   TABLE DATA           d   COPY public.shipping_zone_province (shipping_zone_province_id, uuid, zone_id, province) FROM stdin;
    public          postgres    false    285       4038.dat �          0    18555 	   tax_class 
   TABLE DATA           =   COPY public.tax_class (tax_class_id, uuid, name) FROM stdin;
    public          postgres    false    288       4041.dat �          0    18562    tax_rate 
   TABLE DATA           �   COPY public.tax_rate (tax_rate_id, uuid, name, tax_class_id, country, province, postcode, rate, is_compound, priority) FROM stdin;
    public          postgres    false    290       4043.dat �          0    18575    url_rewrite 
   TABLE DATA           t   COPY public.url_rewrite (url_rewrite_id, language, request_path, target_path, entity_uuid, entity_type) FROM stdin;
    public          postgres    false    292       4045.dat �          0    18582    variant_group 
   TABLE DATA           �   COPY public.variant_group (variant_group_id, uuid, attribute_group_id, attribute_one, attribute_two, attribute_three, attribute_four, attribute_five, visibility) FROM stdin;
    public          postgres    false    294       4047.dat �           0    0    admin_user_admin_user_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.admin_user_admin_user_id_seq', 2, true);
          public          postgres    false    210         �           0    0    attribute_attribute_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.attribute_attribute_id_seq', 2, true);
          public          postgres    false    212         �           0    0 &   attribute_group_attribute_group_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.attribute_group_attribute_group_id_seq', 1, true);
          public          postgres    false    214         �           0    0 0   attribute_group_link_attribute_group_link_id_seq    SEQUENCE SET     ^   SELECT pg_catalog.setval('public.attribute_group_link_attribute_group_link_id_seq', 2, true);
          public          postgres    false    216         �           0    0 (   attribute_option_attribute_option_id_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public.attribute_option_attribute_option_id_seq', 6, true);
          public          postgres    false    218         �           0    0     cart_address_cart_address_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.cart_address_cart_address_id_seq', 15, true);
          public          postgres    false    221         �           0    0    cart_cart_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.cart_cart_id_seq', 10, true);
          public          postgres    false    222         �           0    0    cart_item_cart_item_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.cart_item_cart_item_id_seq', 15, true);
          public          postgres    false    224         �           0    0    category_category_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.category_category_id_seq', 26, true);
          public          postgres    false    226         �           0    0 0   category_description_category_description_id_seq    SEQUENCE SET     _   SELECT pg_catalog.setval('public.category_description_category_description_id_seq', 26, true);
          public          postgres    false    228         �           0    0    cms_page_cms_page_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.cms_page_cms_page_id_seq', 8, true);
          public          postgres    false    230         �           0    0 0   cms_page_description_cms_page_description_id_seq    SEQUENCE SET     ^   SELECT pg_catalog.setval('public.cms_page_description_cms_page_description_id_seq', 8, true);
          public          postgres    false    232         �           0    0    collection_collection_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.collection_collection_id_seq', 6, true);
          public          postgres    false    234         �           0    0    coupon_coupon_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.coupon_coupon_id_seq', 1, true);
          public          postgres    false    236         �           0    0 (   customer_address_customer_address_id_seq    SEQUENCE SET     W   SELECT pg_catalog.setval('public.customer_address_customer_address_id_seq', 1, false);
          public          postgres    false    239         �           0    0    customer_customer_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.customer_customer_id_seq', 1, true);
          public          postgres    false    240         �           0    0 $   customer_group_customer_group_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.customer_group_customer_group_id_seq', 1, true);
          public          postgres    false    242         �           0    0    event_event_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.event_event_id_seq', 635, true);
          public          postgres    false    244         �           0    0    migration_migration_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.migration_migration_id_seq', 25, true);
          public          postgres    false    246         �           0    0 $   order_activity_order_activity_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.order_activity_order_activity_id_seq', 3, true);
          public          postgres    false    249         �           0    0 "   order_address_order_address_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.order_address_order_address_id_seq', 4, true);
          public          postgres    false    251         �           0    0    order_item_order_item_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.order_item_order_item_id_seq', 2, true);
          public          postgres    false    253         �           0    0    order_order_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.order_order_id_seq', 2, true);
          public          postgres    false    254         �           0    0 .   payment_transaction_payment_transaction_id_seq    SEQUENCE SET     \   SELECT pg_catalog.setval('public.payment_transaction_payment_transaction_id_seq', 1, true);
          public          postgres    false    256         �           0    0 ?   product_attribute_value_index_product_attribute_value_index_seq    SEQUENCE SET     o   SELECT pg_catalog.setval('public.product_attribute_value_index_product_attribute_value_index_seq', 276, true);
          public          postgres    false    259         �           0    0 ,   product_collection_product_collection_id_seq    SEQUENCE SET     [   SELECT pg_catalog.setval('public.product_collection_product_collection_id_seq', 15, true);
          public          postgres    false    261         �           0    0 2   product_custom_option_product_custom_option_id_seq    SEQUENCE SET     a   SELECT pg_catalog.setval('public.product_custom_option_product_custom_option_id_seq', 1, false);
          public          postgres    false    263         �           0    0 >   product_custom_option_value_product_custom_option_value_id_seq    SEQUENCE SET     m   SELECT pg_catalog.setval('public.product_custom_option_value_product_custom_option_value_id_seq', 1, false);
          public          postgres    false    265         �           0    0 .   product_description_product_description_id_seq    SEQUENCE SET     ]   SELECT pg_catalog.setval('public.product_description_product_description_id_seq', 33, true);
          public          postgres    false    267         �           0    0 "   product_image_product_image_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.product_image_product_image_id_seq', 130, true);
          public          postgres    false    269         �           0    0 *   product_inventory_product_inventory_id_seq    SEQUENCE SET     Y   SELECT pg_catalog.setval('public.product_inventory_product_inventory_id_seq', 32, true);
          public          postgres    false    271         �           0    0    product_product_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.product_product_id_seq', 41, true);
          public          postgres    false    272         �           0    0 0   reset_password_token_reset_password_token_id_seq    SEQUENCE SET     _   SELECT pg_catalog.setval('public.reset_password_token_reset_password_token_id_seq', 1, false);
          public          postgres    false    274         �           0    0    setting_setting_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.setting_setting_id_seq', 12, true);
          public          postgres    false    277         �           0    0    shipment_shipment_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.shipment_shipment_id_seq', 1, false);
          public          postgres    false    279         �           0    0 &   shipping_method_shipping_method_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.shipping_method_shipping_method_id_seq', 1, true);
          public          postgres    false    281         �           0    0 0   shipping_zone_method_shipping_zone_method_id_seq    SEQUENCE SET     ^   SELECT pg_catalog.setval('public.shipping_zone_method_shipping_zone_method_id_seq', 2, true);
          public          postgres    false    284         �           0    0 4   shipping_zone_province_shipping_zone_province_id_seq    SEQUENCE SET     c   SELECT pg_catalog.setval('public.shipping_zone_province_shipping_zone_province_id_seq', 1, false);
          public          postgres    false    286         �           0    0 "   shipping_zone_shipping_zone_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.shipping_zone_shipping_zone_id_seq', 2, true);
          public          postgres    false    287         �           0    0    tax_class_tax_class_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.tax_class_tax_class_id_seq', 1, true);
          public          postgres    false    289                     0    0    tax_rate_tax_rate_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.tax_rate_tax_rate_id_seq', 1, true);
          public          postgres    false    291                    0    0    url_rewrite_url_rewrite_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.url_rewrite_url_rewrite_id_seq', 524, true);
          public          postgres    false    293                    0    0 "   variant_group_variant_group_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.variant_group_variant_group_id_seq', 5, true);
          public          postgres    false    295         �           2606    18589 "   admin_user ADMIN_USER_EMAIL_UNIQUE 
   CONSTRAINT     `   ALTER TABLE ONLY public.admin_user
    ADD CONSTRAINT "ADMIN_USER_EMAIL_UNIQUE" UNIQUE (email);
 N   ALTER TABLE ONLY public.admin_user DROP CONSTRAINT "ADMIN_USER_EMAIL_UNIQUE";
       public            postgres    false    209         �           2606    18591 !   admin_user ADMIN_USER_UUID_UNIQUE 
   CONSTRAINT     ^   ALTER TABLE ONLY public.admin_user
    ADD CONSTRAINT "ADMIN_USER_UUID_UNIQUE" UNIQUE (uuid);
 M   ALTER TABLE ONLY public.admin_user DROP CONSTRAINT "ADMIN_USER_UUID_UNIQUE";
       public            postgres    false    209         �           2606    18593    attribute ATTRIBUTE_CODE_UNIQUE 
   CONSTRAINT     f   ALTER TABLE ONLY public.attribute
    ADD CONSTRAINT "ATTRIBUTE_CODE_UNIQUE" UNIQUE (attribute_code);
 K   ALTER TABLE ONLY public.attribute DROP CONSTRAINT "ATTRIBUTE_CODE_UNIQUE";
       public            postgres    false    211         �           2606    18595 $   attribute ATTRIBUTE_CODE_UUID_UNIQUE 
   CONSTRAINT     a   ALTER TABLE ONLY public.attribute
    ADD CONSTRAINT "ATTRIBUTE_CODE_UUID_UNIQUE" UNIQUE (uuid);
 P   ALTER TABLE ONLY public.attribute DROP CONSTRAINT "ATTRIBUTE_CODE_UUID_UNIQUE";
       public            postgres    false    211         �           2606    18597 0   attribute_group_link ATTRIBUTE_GROUP_LINK_UNIQUE 
   CONSTRAINT        ALTER TABLE ONLY public.attribute_group_link
    ADD CONSTRAINT "ATTRIBUTE_GROUP_LINK_UNIQUE" UNIQUE (attribute_id, group_id);
 \   ALTER TABLE ONLY public.attribute_group_link DROP CONSTRAINT "ATTRIBUTE_GROUP_LINK_UNIQUE";
       public            postgres    false    215    215         �           2606    18599 +   attribute_group ATTRIBUTE_GROUP_UUID_UNIQUE 
   CONSTRAINT     h   ALTER TABLE ONLY public.attribute_group
    ADD CONSTRAINT "ATTRIBUTE_GROUP_UUID_UNIQUE" UNIQUE (uuid);
 W   ALTER TABLE ONLY public.attribute_group DROP CONSTRAINT "ATTRIBUTE_GROUP_UUID_UNIQUE";
       public            postgres    false    213         �           2606    18601 -   attribute_option ATTRIBUTE_OPTION_UUID_UNIQUE 
   CONSTRAINT     j   ALTER TABLE ONLY public.attribute_option
    ADD CONSTRAINT "ATTRIBUTE_OPTION_UUID_UNIQUE" UNIQUE (uuid);
 Y   ALTER TABLE ONLY public.attribute_option DROP CONSTRAINT "ATTRIBUTE_OPTION_UUID_UNIQUE";
       public            postgres    false    217         �           2606    18603 %   cart_address CART_ADDRESS_UUID_UNIQUE 
   CONSTRAINT     b   ALTER TABLE ONLY public.cart_address
    ADD CONSTRAINT "CART_ADDRESS_UUID_UNIQUE" UNIQUE (uuid);
 Q   ALTER TABLE ONLY public.cart_address DROP CONSTRAINT "CART_ADDRESS_UUID_UNIQUE";
       public            postgres    false    220         �           2606    18605    cart_item CART_ITEM_UUID_UNIQUE 
   CONSTRAINT     \   ALTER TABLE ONLY public.cart_item
    ADD CONSTRAINT "CART_ITEM_UUID_UNIQUE" UNIQUE (uuid);
 K   ALTER TABLE ONLY public.cart_item DROP CONSTRAINT "CART_ITEM_UUID_UNIQUE";
       public            postgres    false    223         �           2606    18607    cart CART_UUID_UNIQUE 
   CONSTRAINT     R   ALTER TABLE ONLY public.cart
    ADD CONSTRAINT "CART_UUID_UNIQUE" UNIQUE (uuid);
 A   ALTER TABLE ONLY public.cart DROP CONSTRAINT "CART_UUID_UNIQUE";
       public            postgres    false    219         �           2606    18609 '   category_description CATEGORY_ID_UNIQUE 
   CONSTRAINT     �   ALTER TABLE ONLY public.category_description
    ADD CONSTRAINT "CATEGORY_ID_UNIQUE" UNIQUE (category_description_category_id);
 S   ALTER TABLE ONLY public.category_description DROP CONSTRAINT "CATEGORY_ID_UNIQUE";
       public            postgres    false    227         �           2606    18611 ,   category_description CATEGORY_URL_KEY_UNIQUE 
   CONSTRAINT     l   ALTER TABLE ONLY public.category_description
    ADD CONSTRAINT "CATEGORY_URL_KEY_UNIQUE" UNIQUE (url_key);
 X   ALTER TABLE ONLY public.category_description DROP CONSTRAINT "CATEGORY_URL_KEY_UNIQUE";
       public            postgres    false    227         �           2606    18613    category CATEGORY_UUID_UNIQUE 
   CONSTRAINT     Z   ALTER TABLE ONLY public.category
    ADD CONSTRAINT "CATEGORY_UUID_UNIQUE" UNIQUE (uuid);
 I   ALTER TABLE ONLY public.category DROP CONSTRAINT "CATEGORY_UUID_UNIQUE";
       public            postgres    false    225         �           2606    18615    cms_page CMS_PAGE_UUID 
   CONSTRAINT     S   ALTER TABLE ONLY public.cms_page
    ADD CONSTRAINT "CMS_PAGE_UUID" UNIQUE (uuid);
 B   ALTER TABLE ONLY public.cms_page DROP CONSTRAINT "CMS_PAGE_UUID";
       public            postgres    false    229                    2606    18617 !   collection COLLECTION_CODE_UNIQUE 
   CONSTRAINT     ^   ALTER TABLE ONLY public.collection
    ADD CONSTRAINT "COLLECTION_CODE_UNIQUE" UNIQUE (code);
 M   ALTER TABLE ONLY public.collection DROP CONSTRAINT "COLLECTION_CODE_UNIQUE";
       public            postgres    false    233                    2606    18619 !   collection COLLECTION_UUID_UNIQUE 
   CONSTRAINT     ^   ALTER TABLE ONLY public.collection
    ADD CONSTRAINT "COLLECTION_UUID_UNIQUE" UNIQUE (uuid);
 M   ALTER TABLE ONLY public.collection DROP CONSTRAINT "COLLECTION_UUID_UNIQUE";
       public            postgres    false    233         	           2606    18621    coupon COUPON_UNIQUE 
   CONSTRAINT     S   ALTER TABLE ONLY public.coupon
    ADD CONSTRAINT "COUPON_UNIQUE" UNIQUE (coupon);
 @   ALTER TABLE ONLY public.coupon DROP CONSTRAINT "COUPON_UNIQUE";
       public            postgres    false    235                    2606    18623    coupon COUPON_UUID_UNIQUE 
   CONSTRAINT     V   ALTER TABLE ONLY public.coupon
    ADD CONSTRAINT "COUPON_UUID_UNIQUE" UNIQUE (uuid);
 E   ALTER TABLE ONLY public.coupon DROP CONSTRAINT "COUPON_UUID_UNIQUE";
       public            postgres    false    235                    2606    18625 -   customer_address CUSTOMER_ADDRESS_UUID_UNIQUE 
   CONSTRAINT     j   ALTER TABLE ONLY public.customer_address
    ADD CONSTRAINT "CUSTOMER_ADDRESS_UUID_UNIQUE" UNIQUE (uuid);
 Y   ALTER TABLE ONLY public.customer_address DROP CONSTRAINT "CUSTOMER_ADDRESS_UUID_UNIQUE";
       public            postgres    false    238                    2606    18627    customer CUSTOMER_UUID_UNIQUE 
   CONSTRAINT     Z   ALTER TABLE ONLY public.customer
    ADD CONSTRAINT "CUSTOMER_UUID_UNIQUE" UNIQUE (uuid);
 I   ALTER TABLE ONLY public.customer DROP CONSTRAINT "CUSTOMER_UUID_UNIQUE";
       public            postgres    false    237                    2606    18629    customer EMAIL_UNIQUE 
   CONSTRAINT     S   ALTER TABLE ONLY public.customer
    ADD CONSTRAINT "EMAIL_UNIQUE" UNIQUE (email);
 A   ALTER TABLE ONLY public.customer DROP CONSTRAINT "EMAIL_UNIQUE";
       public            postgres    false    237                    2606    18631    event EVENT_UUID 
   CONSTRAINT     M   ALTER TABLE ONLY public.event
    ADD CONSTRAINT "EVENT_UUID" UNIQUE (uuid);
 <   ALTER TABLE ONLY public.event DROP CONSTRAINT "EVENT_UUID";
       public            postgres    false    243         �           2606    18633 '   shipping_zone_method METHOD_ZONE_UNIQUE 
   CONSTRAINT     r   ALTER TABLE ONLY public.shipping_zone_method
    ADD CONSTRAINT "METHOD_ZONE_UNIQUE" UNIQUE (zone_id, method_id);
 S   ALTER TABLE ONLY public.shipping_zone_method DROP CONSTRAINT "METHOD_ZONE_UNIQUE";
       public            postgres    false    283    283         !           2606    18635    migration MODULE_UNIQUE 
   CONSTRAINT     V   ALTER TABLE ONLY public.migration
    ADD CONSTRAINT "MODULE_UNIQUE" UNIQUE (module);
 C   ALTER TABLE ONLY public.migration DROP CONSTRAINT "MODULE_UNIQUE";
       public            postgres    false    245         K           2606    18637 1   product_attribute_value_index OPTION_VALUE_UNIQUE 
   CONSTRAINT     �   ALTER TABLE ONLY public.product_attribute_value_index
    ADD CONSTRAINT "OPTION_VALUE_UNIQUE" UNIQUE (product_id, attribute_id, option_id);
 ]   ALTER TABLE ONLY public.product_attribute_value_index DROP CONSTRAINT "OPTION_VALUE_UNIQUE";
       public            postgres    false    258    258    258         ,           2606    18639 )   order_activity ORDER_ACTIVITY_UUID_UNIQUE 
   CONSTRAINT     f   ALTER TABLE ONLY public.order_activity
    ADD CONSTRAINT "ORDER_ACTIVITY_UUID_UNIQUE" UNIQUE (uuid);
 U   ALTER TABLE ONLY public.order_activity DROP CONSTRAINT "ORDER_ACTIVITY_UUID_UNIQUE";
       public            postgres    false    248         0           2606    18641 '   order_address ORDER_ADDRESS_UUID_UNIQUE 
   CONSTRAINT     d   ALTER TABLE ONLY public.order_address
    ADD CONSTRAINT "ORDER_ADDRESS_UUID_UNIQUE" UNIQUE (uuid);
 S   ALTER TABLE ONLY public.order_address DROP CONSTRAINT "ORDER_ADDRESS_UUID_UNIQUE";
       public            postgres    false    250         5           2606    18643 !   order_item ORDER_ITEM_UUID_UNIQUE 
   CONSTRAINT     ^   ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT "ORDER_ITEM_UUID_UNIQUE" UNIQUE (uuid);
 M   ALTER TABLE ONLY public.order_item DROP CONSTRAINT "ORDER_ITEM_UUID_UNIQUE";
       public            postgres    false    252         %           2606    18645    order ORDER_NUMBER_UNIQUE 
   CONSTRAINT     `   ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "ORDER_NUMBER_UNIQUE" UNIQUE (order_number);
 G   ALTER TABLE ONLY public."order" DROP CONSTRAINT "ORDER_NUMBER_UNIQUE";
       public            postgres    false    247         '           2606    18647    order ORDER_UUID_UNIQUE 
   CONSTRAINT     V   ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "ORDER_UUID_UNIQUE" UNIQUE (uuid);
 E   ALTER TABLE ONLY public."order" DROP CONSTRAINT "ORDER_UUID_UNIQUE";
       public            postgres    false    247         �           2606    18649 #   cms_page_description PAGE_ID_UNIQUE 
   CONSTRAINT     |   ALTER TABLE ONLY public.cms_page_description
    ADD CONSTRAINT "PAGE_ID_UNIQUE" UNIQUE (cms_page_description_cms_page_id);
 O   ALTER TABLE ONLY public.cms_page_description DROP CONSTRAINT "PAGE_ID_UNIQUE";
       public            postgres    false    231         :           2606    18651 3   payment_transaction PAYMENT_TRANSACTION_UUID_UNIQUE 
   CONSTRAINT     p   ALTER TABLE ONLY public.payment_transaction
    ADD CONSTRAINT "PAYMENT_TRANSACTION_UUID_UNIQUE" UNIQUE (uuid);
 _   ALTER TABLE ONLY public.payment_transaction DROP CONSTRAINT "PAYMENT_TRANSACTION_UUID_UNIQUE";
       public            postgres    false    255         Q           2606    18653 ,   product_collection PRODUCT_COLLECTION_UNIQUE 
   CONSTRAINT     ~   ALTER TABLE ONLY public.product_collection
    ADD CONSTRAINT "PRODUCT_COLLECTION_UNIQUE" UNIQUE (collection_id, product_id);
 X   ALTER TABLE ONLY public.product_collection DROP CONSTRAINT "PRODUCT_COLLECTION_UNIQUE";
       public            postgres    false    260    260         V           2606    18655 7   product_custom_option PRODUCT_CUSTOM_OPTION_UUID_UNIQUE 
   CONSTRAINT     t   ALTER TABLE ONLY public.product_custom_option
    ADD CONSTRAINT "PRODUCT_CUSTOM_OPTION_UUID_UNIQUE" UNIQUE (uuid);
 c   ALTER TABLE ONLY public.product_custom_option DROP CONSTRAINT "PRODUCT_CUSTOM_OPTION_UUID_UNIQUE";
       public            postgres    false    262         [           2606    18657 C   product_custom_option_value PRODUCT_CUSTOM_OPTION_VALUE_UUID_UNIQUE 
   CONSTRAINT     �   ALTER TABLE ONLY public.product_custom_option_value
    ADD CONSTRAINT "PRODUCT_CUSTOM_OPTION_VALUE_UUID_UNIQUE" UNIQUE (uuid);
 o   ALTER TABLE ONLY public.product_custom_option_value DROP CONSTRAINT "PRODUCT_CUSTOM_OPTION_VALUE_UUID_UNIQUE";
       public            postgres    false    264         `           2606    18659 %   product_description PRODUCT_ID_UNIQUE 
   CONSTRAINT     |   ALTER TABLE ONLY public.product_description
    ADD CONSTRAINT "PRODUCT_ID_UNIQUE" UNIQUE (product_description_product_id);
 Q   ALTER TABLE ONLY public.product_description DROP CONSTRAINT "PRODUCT_ID_UNIQUE";
       public            postgres    false    266         j           2606    18661 5   product_inventory PRODUCT_INVENTORY_PRODUCT_ID_UNIQUE 
   CONSTRAINT     �   ALTER TABLE ONLY public.product_inventory
    ADD CONSTRAINT "PRODUCT_INVENTORY_PRODUCT_ID_UNIQUE" UNIQUE (product_inventory_product_id);
 a   ALTER TABLE ONLY public.product_inventory DROP CONSTRAINT "PRODUCT_INVENTORY_PRODUCT_ID_UNIQUE";
       public            postgres    false    270         B           2606    18663    product PRODUCT_SKU_UNIQUE 
   CONSTRAINT     V   ALTER TABLE ONLY public.product
    ADD CONSTRAINT "PRODUCT_SKU_UNIQUE" UNIQUE (sku);
 F   ALTER TABLE ONLY public.product DROP CONSTRAINT "PRODUCT_SKU_UNIQUE";
       public            postgres    false    257         c           2606    18665 *   product_description PRODUCT_URL_KEY_UNIQUE 
   CONSTRAINT     j   ALTER TABLE ONLY public.product_description
    ADD CONSTRAINT "PRODUCT_URL_KEY_UNIQUE" UNIQUE (url_key);
 V   ALTER TABLE ONLY public.product_description DROP CONSTRAINT "PRODUCT_URL_KEY_UNIQUE";
       public            postgres    false    266         D           2606    18667    product PRODUCT_UUID_UNIQUE 
   CONSTRAINT     X   ALTER TABLE ONLY public.product
    ADD CONSTRAINT "PRODUCT_UUID_UNIQUE" UNIQUE (uuid);
 G   ALTER TABLE ONLY public.product DROP CONSTRAINT "PRODUCT_UUID_UNIQUE";
       public            postgres    false    257         q           2606    18669    session SESSION_PKEY 
   CONSTRAINT     U   ALTER TABLE ONLY public.session
    ADD CONSTRAINT "SESSION_PKEY" PRIMARY KEY (sid);
 @   ALTER TABLE ONLY public.session DROP CONSTRAINT "SESSION_PKEY";
       public            postgres    false    275         s           2606    18671    setting SETTING_NAME_UNIQUE 
   CONSTRAINT     X   ALTER TABLE ONLY public.setting
    ADD CONSTRAINT "SETTING_NAME_UNIQUE" UNIQUE (name);
 G   ALTER TABLE ONLY public.setting DROP CONSTRAINT "SETTING_NAME_UNIQUE";
       public            postgres    false    276         u           2606    18673    setting SETTING_UUID_UNIQUE 
   CONSTRAINT     X   ALTER TABLE ONLY public.setting
    ADD CONSTRAINT "SETTING_UUID_UNIQUE" UNIQUE (uuid);
 G   ALTER TABLE ONLY public.setting DROP CONSTRAINT "SETTING_UUID_UNIQUE";
       public            postgres    false    276         z           2606    18675    shipment SHIPMENT_UUID_UNIQUE 
   CONSTRAINT     Z   ALTER TABLE ONLY public.shipment
    ADD CONSTRAINT "SHIPMENT_UUID_UNIQUE" UNIQUE (uuid);
 I   ALTER TABLE ONLY public.shipment DROP CONSTRAINT "SHIPMENT_UUID_UNIQUE";
       public            postgres    false    278         ~           2606    18677 +   shipping_method SHIPPING_METHOD_NAME_UNIQUE 
   CONSTRAINT     h   ALTER TABLE ONLY public.shipping_method
    ADD CONSTRAINT "SHIPPING_METHOD_NAME_UNIQUE" UNIQUE (name);
 W   ALTER TABLE ONLY public.shipping_method DROP CONSTRAINT "SHIPPING_METHOD_NAME_UNIQUE";
       public            postgres    false    280         �           2606    18679 +   shipping_method SHIPPING_METHOD_UUID_UNIQUE 
   CONSTRAINT     h   ALTER TABLE ONLY public.shipping_method
    ADD CONSTRAINT "SHIPPING_METHOD_UUID_UNIQUE" UNIQUE (uuid);
 W   ALTER TABLE ONLY public.shipping_method DROP CONSTRAINT "SHIPPING_METHOD_UUID_UNIQUE";
       public            postgres    false    280         �           2606    18681 =   shipping_zone_province SHIPPING_ZONE_PROVINCE_PROVINCE_UNIQUE 
   CONSTRAINT     ~   ALTER TABLE ONLY public.shipping_zone_province
    ADD CONSTRAINT "SHIPPING_ZONE_PROVINCE_PROVINCE_UNIQUE" UNIQUE (province);
 i   ALTER TABLE ONLY public.shipping_zone_province DROP CONSTRAINT "SHIPPING_ZONE_PROVINCE_PROVINCE_UNIQUE";
       public            postgres    false    285         �           2606    18683 9   shipping_zone_province SHIPPING_ZONE_PROVINCE_UUID_UNIQUE 
   CONSTRAINT     v   ALTER TABLE ONLY public.shipping_zone_province
    ADD CONSTRAINT "SHIPPING_ZONE_PROVINCE_UUID_UNIQUE" UNIQUE (uuid);
 e   ALTER TABLE ONLY public.shipping_zone_province DROP CONSTRAINT "SHIPPING_ZONE_PROVINCE_UUID_UNIQUE";
       public            postgres    false    285         �           2606    18685 '   shipping_zone SHIPPING_ZONE_UUID_UNIQUE 
   CONSTRAINT     d   ALTER TABLE ONLY public.shipping_zone
    ADD CONSTRAINT "SHIPPING_ZONE_UUID_UNIQUE" UNIQUE (uuid);
 S   ALTER TABLE ONLY public.shipping_zone DROP CONSTRAINT "SHIPPING_ZONE_UUID_UNIQUE";
       public            postgres    false    282         �           2606    18687    tax_class TAX_CLASS_UUID_UNIQUE 
   CONSTRAINT     \   ALTER TABLE ONLY public.tax_class
    ADD CONSTRAINT "TAX_CLASS_UUID_UNIQUE" UNIQUE (uuid);
 K   ALTER TABLE ONLY public.tax_class DROP CONSTRAINT "TAX_CLASS_UUID_UNIQUE";
       public            postgres    false    288         �           2606    18689 !   tax_rate TAX_RATE_PRIORITY_UNIQUE 
   CONSTRAINT     p   ALTER TABLE ONLY public.tax_rate
    ADD CONSTRAINT "TAX_RATE_PRIORITY_UNIQUE" UNIQUE (priority, tax_class_id);
 M   ALTER TABLE ONLY public.tax_rate DROP CONSTRAINT "TAX_RATE_PRIORITY_UNIQUE";
       public            postgres    false    290    290         �           2606    18691    tax_rate TAX_RATE_UUID_UNIQUE 
   CONSTRAINT     Z   ALTER TABLE ONLY public.tax_rate
    ADD CONSTRAINT "TAX_RATE_UUID_UNIQUE" UNIQUE (uuid);
 I   ALTER TABLE ONLY public.tax_rate DROP CONSTRAINT "TAX_RATE_UUID_UNIQUE";
       public            postgres    false    290         <           2606    18693 7   payment_transaction UNQ_PAYMENT_TRANSACTION_ID_ORDER_ID 
   CONSTRAINT     �   ALTER TABLE ONLY public.payment_transaction
    ADD CONSTRAINT "UNQ_PAYMENT_TRANSACTION_ID_ORDER_ID" UNIQUE (payment_transaction_order_id, transaction_id);
 c   ALTER TABLE ONLY public.payment_transaction DROP CONSTRAINT "UNQ_PAYMENT_TRANSACTION_ID_ORDER_ID";
       public            postgres    false    255    255         �           2606    18695 #   cms_page_description URL_KEY_UNIQUE 
   CONSTRAINT     c   ALTER TABLE ONLY public.cms_page_description
    ADD CONSTRAINT "URL_KEY_UNIQUE" UNIQUE (url_key);
 O   ALTER TABLE ONLY public.cms_page_description DROP CONSTRAINT "URL_KEY_UNIQUE";
       public            postgres    false    231         �           2606    18697 #   url_rewrite URL_REWRITE_PATH_UNIQUE 
   CONSTRAINT     q   ALTER TABLE ONLY public.url_rewrite
    ADD CONSTRAINT "URL_REWRITE_PATH_UNIQUE" UNIQUE (language, entity_uuid);
 O   ALTER TABLE ONLY public.url_rewrite DROP CONSTRAINT "URL_REWRITE_PATH_UNIQUE";
       public            postgres    false    292    292         �           2606    18699 '   variant_group VARIANT_GROUP_UUID_UNIQUE 
   CONSTRAINT     d   ALTER TABLE ONLY public.variant_group
    ADD CONSTRAINT "VARIANT_GROUP_UUID_UNIQUE" UNIQUE (uuid);
 S   ALTER TABLE ONLY public.variant_group DROP CONSTRAINT "VARIANT_GROUP_UUID_UNIQUE";
       public            postgres    false    294         �           2606    18701    admin_user admin_user_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.admin_user
    ADD CONSTRAINT admin_user_pkey PRIMARY KEY (admin_user_id);
 D   ALTER TABLE ONLY public.admin_user DROP CONSTRAINT admin_user_pkey;
       public            postgres    false    209         �           2606    18703 .   attribute_group_link attribute_group_link_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.attribute_group_link
    ADD CONSTRAINT attribute_group_link_pkey PRIMARY KEY (attribute_group_link_id);
 X   ALTER TABLE ONLY public.attribute_group_link DROP CONSTRAINT attribute_group_link_pkey;
       public            postgres    false    215         �           2606    18705 $   attribute_group attribute_group_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.attribute_group
    ADD CONSTRAINT attribute_group_pkey PRIMARY KEY (attribute_group_id);
 N   ALTER TABLE ONLY public.attribute_group DROP CONSTRAINT attribute_group_pkey;
       public            postgres    false    213         �           2606    18707 &   attribute_option attribute_option_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY public.attribute_option
    ADD CONSTRAINT attribute_option_pkey PRIMARY KEY (attribute_option_id);
 P   ALTER TABLE ONLY public.attribute_option DROP CONSTRAINT attribute_option_pkey;
       public            postgres    false    217         �           2606    18709    attribute attribute_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.attribute
    ADD CONSTRAINT attribute_pkey PRIMARY KEY (attribute_id);
 B   ALTER TABLE ONLY public.attribute DROP CONSTRAINT attribute_pkey;
       public            postgres    false    211         �           2606    18711    cart_address cart_address_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.cart_address
    ADD CONSTRAINT cart_address_pkey PRIMARY KEY (cart_address_id);
 H   ALTER TABLE ONLY public.cart_address DROP CONSTRAINT cart_address_pkey;
       public            postgres    false    220         �           2606    18713    cart_item cart_item_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.cart_item
    ADD CONSTRAINT cart_item_pkey PRIMARY KEY (cart_item_id);
 B   ALTER TABLE ONLY public.cart_item DROP CONSTRAINT cart_item_pkey;
       public            postgres    false    223         �           2606    18715    cart cart_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_pkey PRIMARY KEY (cart_id);
 8   ALTER TABLE ONLY public.cart DROP CONSTRAINT cart_pkey;
       public            postgres    false    219         �           2606    18717 .   category_description category_description_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.category_description
    ADD CONSTRAINT category_description_pkey PRIMARY KEY (category_description_id);
 X   ALTER TABLE ONLY public.category_description DROP CONSTRAINT category_description_pkey;
       public            postgres    false    227         �           2606    18719    category category_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (category_id);
 @   ALTER TABLE ONLY public.category DROP CONSTRAINT category_pkey;
       public            postgres    false    225                    2606    18721 .   cms_page_description cms_page_description_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.cms_page_description
    ADD CONSTRAINT cms_page_description_pkey PRIMARY KEY (cms_page_description_id);
 X   ALTER TABLE ONLY public.cms_page_description DROP CONSTRAINT cms_page_description_pkey;
       public            postgres    false    231         �           2606    18723    cms_page cms_page_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.cms_page
    ADD CONSTRAINT cms_page_pkey PRIMARY KEY (cms_page_id);
 @   ALTER TABLE ONLY public.cms_page DROP CONSTRAINT cms_page_pkey;
       public            postgres    false    229                    2606    18725    collection collection_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.collection
    ADD CONSTRAINT collection_pkey PRIMARY KEY (collection_id);
 D   ALTER TABLE ONLY public.collection DROP CONSTRAINT collection_pkey;
       public            postgres    false    233                    2606    18727    coupon coupon_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.coupon
    ADD CONSTRAINT coupon_pkey PRIMARY KEY (coupon_id);
 <   ALTER TABLE ONLY public.coupon DROP CONSTRAINT coupon_pkey;
       public            postgres    false    235                    2606    18729 &   customer_address customer_address_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY public.customer_address
    ADD CONSTRAINT customer_address_pkey PRIMARY KEY (customer_address_id);
 P   ALTER TABLE ONLY public.customer_address DROP CONSTRAINT customer_address_pkey;
       public            postgres    false    238                    2606    18731 "   customer_group customer_group_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.customer_group
    ADD CONSTRAINT customer_group_pkey PRIMARY KEY (customer_group_id);
 L   ALTER TABLE ONLY public.customer_group DROP CONSTRAINT customer_group_pkey;
       public            postgres    false    241                    2606    18733    customer customer_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);
 @   ALTER TABLE ONLY public.customer DROP CONSTRAINT customer_pkey;
       public            postgres    false    237                    2606    18735    event event_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_pkey PRIMARY KEY (event_id);
 :   ALTER TABLE ONLY public.event DROP CONSTRAINT event_pkey;
       public            postgres    false    243         #           2606    18737    migration migration_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.migration
    ADD CONSTRAINT migration_pkey PRIMARY KEY (migration_id);
 B   ALTER TABLE ONLY public.migration DROP CONSTRAINT migration_pkey;
       public            postgres    false    245         .           2606    18739 "   order_activity order_activity_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.order_activity
    ADD CONSTRAINT order_activity_pkey PRIMARY KEY (order_activity_id);
 L   ALTER TABLE ONLY public.order_activity DROP CONSTRAINT order_activity_pkey;
       public            postgres    false    248         2           2606    18741     order_address order_address_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.order_address
    ADD CONSTRAINT order_address_pkey PRIMARY KEY (order_address_id);
 J   ALTER TABLE ONLY public.order_address DROP CONSTRAINT order_address_pkey;
       public            postgres    false    250         7           2606    18743    order_item order_item_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT order_item_pkey PRIMARY KEY (order_item_id);
 D   ALTER TABLE ONLY public.order_item DROP CONSTRAINT order_item_pkey;
       public            postgres    false    252         )           2606    18745    order order_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY (order_id);
 <   ALTER TABLE ONLY public."order" DROP CONSTRAINT order_pkey;
       public            postgres    false    247         >           2606    18747 ,   payment_transaction payment_transaction_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.payment_transaction
    ADD CONSTRAINT payment_transaction_pkey PRIMARY KEY (payment_transaction_id);
 V   ALTER TABLE ONLY public.payment_transaction DROP CONSTRAINT payment_transaction_pkey;
       public            postgres    false    255         M           2606    18749 @   product_attribute_value_index product_attribute_value_index_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.product_attribute_value_index
    ADD CONSTRAINT product_attribute_value_index_pkey PRIMARY KEY (product_attribute_value_index_id);
 j   ALTER TABLE ONLY public.product_attribute_value_index DROP CONSTRAINT product_attribute_value_index_pkey;
       public            postgres    false    258         S           2606    18751 *   product_collection product_collection_pkey 
   CONSTRAINT     {   ALTER TABLE ONLY public.product_collection
    ADD CONSTRAINT product_collection_pkey PRIMARY KEY (product_collection_id);
 T   ALTER TABLE ONLY public.product_collection DROP CONSTRAINT product_collection_pkey;
       public            postgres    false    260         X           2606    18753 0   product_custom_option product_custom_option_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.product_custom_option
    ADD CONSTRAINT product_custom_option_pkey PRIMARY KEY (product_custom_option_id);
 Z   ALTER TABLE ONLY public.product_custom_option DROP CONSTRAINT product_custom_option_pkey;
       public            postgres    false    262         ]           2606    18755 <   product_custom_option_value product_custom_option_value_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.product_custom_option_value
    ADD CONSTRAINT product_custom_option_value_pkey PRIMARY KEY (product_custom_option_value_id);
 f   ALTER TABLE ONLY public.product_custom_option_value DROP CONSTRAINT product_custom_option_value_pkey;
       public            postgres    false    264         e           2606    18757 ,   product_description product_description_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.product_description
    ADD CONSTRAINT product_description_pkey PRIMARY KEY (product_description_id);
 V   ALTER TABLE ONLY public.product_description DROP CONSTRAINT product_description_pkey;
       public            postgres    false    266         h           2606    18759     product_image product_image_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.product_image
    ADD CONSTRAINT product_image_pkey PRIMARY KEY (product_image_id);
 J   ALTER TABLE ONLY public.product_image DROP CONSTRAINT product_image_pkey;
       public            postgres    false    268         l           2606    18761 (   product_inventory product_inventory_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.product_inventory
    ADD CONSTRAINT product_inventory_pkey PRIMARY KEY (product_inventory_id);
 R   ALTER TABLE ONLY public.product_inventory DROP CONSTRAINT product_inventory_pkey;
       public            postgres    false    270         F           2606    18763    product product_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (product_id);
 >   ALTER TABLE ONLY public.product DROP CONSTRAINT product_pkey;
       public            postgres    false    257         n           2606    18765 .   reset_password_token reset_password_token_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.reset_password_token
    ADD CONSTRAINT reset_password_token_pkey PRIMARY KEY (reset_password_token_id);
 X   ALTER TABLE ONLY public.reset_password_token DROP CONSTRAINT reset_password_token_pkey;
       public            postgres    false    273         w           2606    18767    setting setting_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.setting
    ADD CONSTRAINT setting_pkey PRIMARY KEY (setting_id);
 >   ALTER TABLE ONLY public.setting DROP CONSTRAINT setting_pkey;
       public            postgres    false    276         |           2606    18769    shipment shipment_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.shipment
    ADD CONSTRAINT shipment_pkey PRIMARY KEY (shipment_id);
 @   ALTER TABLE ONLY public.shipment DROP CONSTRAINT shipment_pkey;
       public            postgres    false    278         �           2606    18771 $   shipping_method shipping_method_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.shipping_method
    ADD CONSTRAINT shipping_method_pkey PRIMARY KEY (shipping_method_id);
 N   ALTER TABLE ONLY public.shipping_method DROP CONSTRAINT shipping_method_pkey;
       public            postgres    false    280         �           2606    18773 .   shipping_zone_method shipping_zone_method_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.shipping_zone_method
    ADD CONSTRAINT shipping_zone_method_pkey PRIMARY KEY (shipping_zone_method_id);
 X   ALTER TABLE ONLY public.shipping_zone_method DROP CONSTRAINT shipping_zone_method_pkey;
       public            postgres    false    283         �           2606    18775     shipping_zone shipping_zone_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.shipping_zone
    ADD CONSTRAINT shipping_zone_pkey PRIMARY KEY (shipping_zone_id);
 J   ALTER TABLE ONLY public.shipping_zone DROP CONSTRAINT shipping_zone_pkey;
       public            postgres    false    282         �           2606    18777 2   shipping_zone_province shipping_zone_province_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.shipping_zone_province
    ADD CONSTRAINT shipping_zone_province_pkey PRIMARY KEY (shipping_zone_province_id);
 \   ALTER TABLE ONLY public.shipping_zone_province DROP CONSTRAINT shipping_zone_province_pkey;
       public            postgres    false    285         �           2606    18779    tax_class tax_class_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.tax_class
    ADD CONSTRAINT tax_class_pkey PRIMARY KEY (tax_class_id);
 B   ALTER TABLE ONLY public.tax_class DROP CONSTRAINT tax_class_pkey;
       public            postgres    false    288         �           2606    18781    tax_rate tax_rate_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.tax_rate
    ADD CONSTRAINT tax_rate_pkey PRIMARY KEY (tax_rate_id);
 @   ALTER TABLE ONLY public.tax_rate DROP CONSTRAINT tax_rate_pkey;
       public            postgres    false    290         �           2606    18783    url_rewrite url_rewrite_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.url_rewrite
    ADD CONSTRAINT url_rewrite_pkey PRIMARY KEY (url_rewrite_id);
 F   ALTER TABLE ONLY public.url_rewrite DROP CONSTRAINT url_rewrite_pkey;
       public            postgres    false    292         �           2606    18785     variant_group variant_group_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.variant_group
    ADD CONSTRAINT variant_group_pkey PRIMARY KEY (variant_group_id);
 J   ALTER TABLE ONLY public.variant_group DROP CONSTRAINT variant_group_pkey;
       public            postgres    false    294         �           1259    18786    FK_ATTRIBUTE_GROUP_VARIANT    INDEX     d   CREATE INDEX "FK_ATTRIBUTE_GROUP_VARIANT" ON public.variant_group USING btree (attribute_group_id);
 0   DROP INDEX public."FK_ATTRIBUTE_GROUP_VARIANT";
       public            postgres    false    294         �           1259    18787    FK_ATTRIBUTE_LINK    INDEX     \   CREATE INDEX "FK_ATTRIBUTE_LINK" ON public.attribute_group_link USING btree (attribute_id);
 '   DROP INDEX public."FK_ATTRIBUTE_LINK";
       public            postgres    false    215         �           1259    18788    FK_ATTRIBUTE_OPTION    INDEX     Z   CREATE INDEX "FK_ATTRIBUTE_OPTION" ON public.attribute_option USING btree (attribute_id);
 )   DROP INDEX public."FK_ATTRIBUTE_OPTION";
       public            postgres    false    217         G           1259    18789    FK_ATTRIBUTE_OPTION_VALUE_LINK    INDEX     o   CREATE INDEX "FK_ATTRIBUTE_OPTION_VALUE_LINK" ON public.product_attribute_value_index USING btree (option_id);
 4   DROP INDEX public."FK_ATTRIBUTE_OPTION_VALUE_LINK";
       public            postgres    false    258         H           1259    18790    FK_ATTRIBUTE_VALUE_LINK    INDEX     k   CREATE INDEX "FK_ATTRIBUTE_VALUE_LINK" ON public.product_attribute_value_index USING btree (attribute_id);
 -   DROP INDEX public."FK_ATTRIBUTE_VALUE_LINK";
       public            postgres    false    258         �           1259    18791    FK_ATTRIBUTE_VARIANT_FIVE    INDEX     _   CREATE INDEX "FK_ATTRIBUTE_VARIANT_FIVE" ON public.variant_group USING btree (attribute_five);
 /   DROP INDEX public."FK_ATTRIBUTE_VARIANT_FIVE";
       public            postgres    false    294         �           1259    18792    FK_ATTRIBUTE_VARIANT_FOUR    INDEX     _   CREATE INDEX "FK_ATTRIBUTE_VARIANT_FOUR" ON public.variant_group USING btree (attribute_four);
 /   DROP INDEX public."FK_ATTRIBUTE_VARIANT_FOUR";
       public            postgres    false    294         �           1259    18793    FK_ATTRIBUTE_VARIANT_ONE    INDEX     ]   CREATE INDEX "FK_ATTRIBUTE_VARIANT_ONE" ON public.variant_group USING btree (attribute_one);
 .   DROP INDEX public."FK_ATTRIBUTE_VARIANT_ONE";
       public            postgres    false    294         �           1259    18794    FK_ATTRIBUTE_VARIANT_THREE    INDEX     a   CREATE INDEX "FK_ATTRIBUTE_VARIANT_THREE" ON public.variant_group USING btree (attribute_three);
 0   DROP INDEX public."FK_ATTRIBUTE_VARIANT_THREE";
       public            postgres    false    294         �           1259    18795    FK_ATTRIBUTE_VARIANT_TWO    INDEX     ]   CREATE INDEX "FK_ATTRIBUTE_VARIANT_TWO" ON public.variant_group USING btree (attribute_two);
 .   DROP INDEX public."FK_ATTRIBUTE_VARIANT_TWO";
       public            postgres    false    294         �           1259    18796    FK_CART_ITEM    INDEX     G   CREATE INDEX "FK_CART_ITEM" ON public.cart_item USING btree (cart_id);
 "   DROP INDEX public."FK_CART_ITEM";
       public            postgres    false    223         �           1259    18797    FK_CART_ITEM_PRODUCT    INDEX     R   CREATE INDEX "FK_CART_ITEM_PRODUCT" ON public.cart_item USING btree (product_id);
 *   DROP INDEX public."FK_CART_ITEM_PRODUCT";
       public            postgres    false    223         �           1259    18798    FK_CART_SHIPPING_ZONE    INDEX     T   CREATE INDEX "FK_CART_SHIPPING_ZONE" ON public.cart USING btree (shipping_zone_id);
 +   DROP INDEX public."FK_CART_SHIPPING_ZONE";
       public            postgres    false    219         �           1259    18799    FK_CATEGORY_DESCRIPTION    INDEX     v   CREATE INDEX "FK_CATEGORY_DESCRIPTION" ON public.category_description USING btree (category_description_category_id);
 -   DROP INDEX public."FK_CATEGORY_DESCRIPTION";
       public            postgres    false    227         �           1259    18800    FK_CMS_PAGE_DESCRIPTION    INDEX     v   CREATE INDEX "FK_CMS_PAGE_DESCRIPTION" ON public.cms_page_description USING btree (cms_page_description_cms_page_id);
 -   DROP INDEX public."FK_CMS_PAGE_DESCRIPTION";
       public            postgres    false    231         N           1259    18801    FK_COLLECTION_PRODUCT_LINK    INDEX     d   CREATE INDEX "FK_COLLECTION_PRODUCT_LINK" ON public.product_collection USING btree (collection_id);
 0   DROP INDEX public."FK_COLLECTION_PRODUCT_LINK";
       public            postgres    false    260                    1259    18802    FK_CUSTOMER_ADDRESS    INDEX     Y   CREATE INDEX "FK_CUSTOMER_ADDRESS" ON public.customer_address USING btree (customer_id);
 )   DROP INDEX public."FK_CUSTOMER_ADDRESS";
       public            postgres    false    238                    1259    18803    FK_CUSTOMER_GROUP    INDEX     L   CREATE INDEX "FK_CUSTOMER_GROUP" ON public.customer USING btree (group_id);
 '   DROP INDEX public."FK_CUSTOMER_GROUP";
       public            postgres    false    237         Y           1259    18804    FK_CUSTOM_OPTION_VALUE    INDEX     e   CREATE INDEX "FK_CUSTOM_OPTION_VALUE" ON public.product_custom_option_value USING btree (option_id);
 ,   DROP INDEX public."FK_CUSTOM_OPTION_VALUE";
       public            postgres    false    264         �           1259    18805    FK_GROUP_LINK    INDEX     T   CREATE INDEX "FK_GROUP_LINK" ON public.attribute_group_link USING btree (group_id);
 #   DROP INDEX public."FK_GROUP_LINK";
       public            postgres    false    215         �           1259    18806    FK_METHOD_ZONE    INDEX     V   CREATE INDEX "FK_METHOD_ZONE" ON public.shipping_zone_method USING btree (method_id);
 $   DROP INDEX public."FK_METHOD_ZONE";
       public            postgres    false    283         3           1259    18807    FK_ORDER    INDEX     P   CREATE INDEX "FK_ORDER" ON public.order_item USING btree (order_item_order_id);
    DROP INDEX public."FK_ORDER";
       public            postgres    false    252         *           1259    18808    FK_ORDER_ACTIVITY    INDEX     a   CREATE INDEX "FK_ORDER_ACTIVITY" ON public.order_activity USING btree (order_activity_order_id);
 '   DROP INDEX public."FK_ORDER_ACTIVITY";
       public            postgres    false    248         x           1259    18809    FK_ORDER_SHIPMENT    INDEX     U   CREATE INDEX "FK_ORDER_SHIPMENT" ON public.shipment USING btree (shipment_order_id);
 '   DROP INDEX public."FK_ORDER_SHIPMENT";
       public            postgres    false    278         8           1259    18810    FK_PAYMENT_TRANSACTION_ORDER    INDEX     v   CREATE INDEX "FK_PAYMENT_TRANSACTION_ORDER" ON public.payment_transaction USING btree (payment_transaction_order_id);
 2   DROP INDEX public."FK_PAYMENT_TRANSACTION_ORDER";
       public            postgres    false    255         ?           1259    18811    FK_PRODUCT_ATTRIBUTE_GROUP    INDEX     T   CREATE INDEX "FK_PRODUCT_ATTRIBUTE_GROUP" ON public.product USING btree (group_id);
 0   DROP INDEX public."FK_PRODUCT_ATTRIBUTE_GROUP";
       public            postgres    false    257         I           1259    18812    FK_PRODUCT_ATTRIBUTE_LINK    INDEX     k   CREATE INDEX "FK_PRODUCT_ATTRIBUTE_LINK" ON public.product_attribute_value_index USING btree (product_id);
 /   DROP INDEX public."FK_PRODUCT_ATTRIBUTE_LINK";
       public            postgres    false    258         O           1259    18813    FK_PRODUCT_COLLECTION_LINK    INDEX     a   CREATE INDEX "FK_PRODUCT_COLLECTION_LINK" ON public.product_collection USING btree (product_id);
 0   DROP INDEX public."FK_PRODUCT_COLLECTION_LINK";
       public            postgres    false    260         T           1259    18814    FK_PRODUCT_CUSTOM_OPTION    INDEX     x   CREATE INDEX "FK_PRODUCT_CUSTOM_OPTION" ON public.product_custom_option USING btree (product_custom_option_product_id);
 .   DROP INDEX public."FK_PRODUCT_CUSTOM_OPTION";
       public            postgres    false    262         ^           1259    18815    FK_PRODUCT_DESCRIPTION    INDEX     r   CREATE INDEX "FK_PRODUCT_DESCRIPTION" ON public.product_description USING btree (product_description_product_id);
 ,   DROP INDEX public."FK_PRODUCT_DESCRIPTION";
       public            postgres    false    266         f           1259    18816    FK_PRODUCT_IMAGE_LINK    INDEX     e   CREATE INDEX "FK_PRODUCT_IMAGE_LINK" ON public.product_image USING btree (product_image_product_id);
 +   DROP INDEX public."FK_PRODUCT_IMAGE_LINK";
       public            postgres    false    268         @           1259    18817    FK_PRODUCT_VARIANT_GROUP    INDEX     Z   CREATE INDEX "FK_PRODUCT_VARIANT_GROUP" ON public.product USING btree (variant_group_id);
 .   DROP INDEX public."FK_PRODUCT_VARIANT_GROUP";
       public            postgres    false    257         �           1259    18818    FK_SHIPPING_ZONE_PROVINCE    INDEX     a   CREATE INDEX "FK_SHIPPING_ZONE_PROVINCE" ON public.shipping_zone_province USING btree (zone_id);
 /   DROP INDEX public."FK_SHIPPING_ZONE_PROVINCE";
       public            postgres    false    285         �           1259    18819    FK_ZONE_METHOD    INDEX     T   CREATE INDEX "FK_ZONE_METHOD" ON public.shipping_zone_method USING btree (zone_id);
 $   DROP INDEX public."FK_ZONE_METHOD";
       public            postgres    false    283         o           1259    18820    IDX_SESSION_EXPIRE    INDEX     J   CREATE INDEX "IDX_SESSION_EXPIRE" ON public.session USING btree (expire);
 (   DROP INDEX public."IDX_SESSION_EXPIRE";
       public            postgres    false    275         a           1259    18821    PRODUCT_SEARCH_INDEX    INDEX     �   CREATE INDEX "PRODUCT_SEARCH_INDEX" ON public.product_description USING gin (to_tsvector('simple'::regconfig, (((name)::text || ' '::text) || description)));
 *   DROP INDEX public."PRODUCT_SEARCH_INDEX";
       public            postgres    false    266    266    266         �           2620    18822 +   category ADD_CATEGORY_CREATED_EVENT_TRIGGER    TRIGGER     �   CREATE TRIGGER "ADD_CATEGORY_CREATED_EVENT_TRIGGER" AFTER INSERT ON public.category FOR EACH ROW EXECUTE FUNCTION public.add_category_created_event();
 F   DROP TRIGGER "ADD_CATEGORY_CREATED_EVENT_TRIGGER" ON public.category;
       public          postgres    false    225    296         �           2620    18823 +   category ADD_CATEGORY_DELETED_EVENT_TRIGGER    TRIGGER     �   CREATE TRIGGER "ADD_CATEGORY_DELETED_EVENT_TRIGGER" AFTER DELETE ON public.category FOR EACH ROW EXECUTE FUNCTION public.add_category_deleted_event();
 F   DROP TRIGGER "ADD_CATEGORY_DELETED_EVENT_TRIGGER" ON public.category;
       public          postgres    false    297    225         �           2620    18824 +   category ADD_CATEGORY_UPDATED_EVENT_TRIGGER    TRIGGER     �   CREATE TRIGGER "ADD_CATEGORY_UPDATED_EVENT_TRIGGER" AFTER UPDATE ON public.category FOR EACH ROW EXECUTE FUNCTION public.add_category_updated_event();
 F   DROP TRIGGER "ADD_CATEGORY_UPDATED_EVENT_TRIGGER" ON public.category;
       public          postgres    false    298    225         �           2620    18825 +   customer ADD_CUSTOMER_CREATED_EVENT_TRIGGER    TRIGGER     �   CREATE TRIGGER "ADD_CUSTOMER_CREATED_EVENT_TRIGGER" AFTER INSERT ON public.customer FOR EACH ROW EXECUTE FUNCTION public.add_customer_created_event();
 F   DROP TRIGGER "ADD_CUSTOMER_CREATED_EVENT_TRIGGER" ON public.customer;
       public          postgres    false    299    237         �           2620    18826 +   customer ADD_CUSTOMER_DELETED_EVENT_TRIGGER    TRIGGER     �   CREATE TRIGGER "ADD_CUSTOMER_DELETED_EVENT_TRIGGER" AFTER DELETE ON public.customer FOR EACH ROW EXECUTE FUNCTION public.add_customer_deleted_event();
 F   DROP TRIGGER "ADD_CUSTOMER_DELETED_EVENT_TRIGGER" ON public.customer;
       public          postgres    false    300    237         �           2620    18827 +   customer ADD_CUSTOMER_UPDATED_EVENT_TRIGGER    TRIGGER     �   CREATE TRIGGER "ADD_CUSTOMER_UPDATED_EVENT_TRIGGER" AFTER UPDATE ON public.customer FOR EACH ROW EXECUTE FUNCTION public.add_customer_updated_event();
 F   DROP TRIGGER "ADD_CUSTOMER_UPDATED_EVENT_TRIGGER" ON public.customer;
       public          postgres    false    301    237         �           2620    18828 5   product_inventory ADD_INVENTORY_UPDATED_EVENT_TRIGGER    TRIGGER     �   CREATE TRIGGER "ADD_INVENTORY_UPDATED_EVENT_TRIGGER" AFTER UPDATE ON public.product_inventory FOR EACH ROW EXECUTE FUNCTION public.add_product_inventory_updated_event();
 P   DROP TRIGGER "ADD_INVENTORY_UPDATED_EVENT_TRIGGER" ON public.product_inventory;
       public          postgres    false    305    270         �           2620    18829 %   order ADD_ORDER_CREATED_EVENT_TRIGGER    TRIGGER     �   CREATE TRIGGER "ADD_ORDER_CREATED_EVENT_TRIGGER" AFTER INSERT ON public."order" FOR EACH ROW EXECUTE FUNCTION public.add_order_created_event();
 B   DROP TRIGGER "ADD_ORDER_CREATED_EVENT_TRIGGER" ON public."order";
       public          postgres    false    302    247         �           2620    18830 )   product ADD_PRODUCT_CREATED_EVENT_TRIGGER    TRIGGER     �   CREATE TRIGGER "ADD_PRODUCT_CREATED_EVENT_TRIGGER" AFTER INSERT ON public.product FOR EACH ROW EXECUTE FUNCTION public.add_product_created_event();
 D   DROP TRIGGER "ADD_PRODUCT_CREATED_EVENT_TRIGGER" ON public.product;
       public          postgres    false    303    257         �           2620    18831 )   product ADD_PRODUCT_DELETED_EVENT_TRIGGER    TRIGGER     �   CREATE TRIGGER "ADD_PRODUCT_DELETED_EVENT_TRIGGER" AFTER DELETE ON public.product FOR EACH ROW EXECUTE FUNCTION public.add_product_deleted_event();
 D   DROP TRIGGER "ADD_PRODUCT_DELETED_EVENT_TRIGGER" ON public.product;
       public          postgres    false    304    257         �           2620    18832 )   product ADD_PRODUCT_UPDATED_EVENT_TRIGGER    TRIGGER     �   CREATE TRIGGER "ADD_PRODUCT_UPDATED_EVENT_TRIGGER" AFTER UPDATE ON public.product FOR EACH ROW EXECUTE FUNCTION public.add_product_updated_event();
 D   DROP TRIGGER "ADD_PRODUCT_UPDATED_EVENT_TRIGGER" ON public.product;
       public          postgres    false    306    257         �           2620    18833 3   category_description BUILD_CATEGORY_URL_KEY_TRIGGER    TRIGGER     �   CREATE TRIGGER "BUILD_CATEGORY_URL_KEY_TRIGGER" BEFORE INSERT OR UPDATE ON public.category_description FOR EACH ROW EXECUTE FUNCTION public.build_url_key();
 N   DROP TRIGGER "BUILD_CATEGORY_URL_KEY_TRIGGER" ON public.category_description;
       public          postgres    false    307    227         �           2620    18834 1   product_description BUILD_PRODUCT_URL_KEY_TRIGGER    TRIGGER     �   CREATE TRIGGER "BUILD_PRODUCT_URL_KEY_TRIGGER" BEFORE INSERT OR UPDATE ON public.product_description FOR EACH ROW EXECUTE FUNCTION public.build_url_key();
 L   DROP TRIGGER "BUILD_PRODUCT_URL_KEY_TRIGGER" ON public.product_description;
       public          postgres    false    266    307         �           2620    18835 &   category DELETE_SUB_CATEGORIES_TRIGGER    TRIGGER     �   CREATE TRIGGER "DELETE_SUB_CATEGORIES_TRIGGER" AFTER DELETE ON public.category FOR EACH ROW EXECUTE FUNCTION public.delete_sub_categories();
 A   DROP TRIGGER "DELETE_SUB_CATEGORIES_TRIGGER" ON public.category;
       public          postgres    false    309    225         �           2620    18836 A   product PREVENT_CHANGING_ATTRIBUTE_GROUP_OF_PRODUCT_WITH_VARIANTS    TRIGGER     �   CREATE TRIGGER "PREVENT_CHANGING_ATTRIBUTE_GROUP_OF_PRODUCT_WITH_VARIANTS" BEFORE UPDATE ON public.product FOR EACH ROW EXECUTE FUNCTION public.prevent_change_attribute_group();
 \   DROP TRIGGER "PREVENT_CHANGING_ATTRIBUTE_GROUP_OF_PRODUCT_WITH_VARIANTS" ON public.product;
       public          postgres    false    314    257         �           2620    18837 <   attribute_group PREVENT_DELETING_THE_DEFAULT_ATTRIBUTE_GROUP    TRIGGER     �   CREATE TRIGGER "PREVENT_DELETING_THE_DEFAULT_ATTRIBUTE_GROUP" BEFORE DELETE ON public.attribute_group FOR EACH ROW EXECUTE FUNCTION public.prevent_delete_default_attribute_group();
 W   DROP TRIGGER "PREVENT_DELETING_THE_DEFAULT_ATTRIBUTE_GROUP" ON public.attribute_group;
       public          postgres    false    315    213         �           2620    18838 :   customer_group PREVENT_DELETING_THE_DEFAULT_CUSTOMER_GROUP    TRIGGER     �   CREATE TRIGGER "PREVENT_DELETING_THE_DEFAULT_CUSTOMER_GROUP" BEFORE DELETE ON public.customer_group FOR EACH ROW EXECUTE FUNCTION public.prevent_delete_default_customer_group();
 U   DROP TRIGGER "PREVENT_DELETING_THE_DEFAULT_CUSTOMER_GROUP" ON public.customer_group;
       public          postgres    false    241    316         �           2620    18839 0   tax_class PREVENT_DELETING_THE_DEFAULT_TAX_CLASS    TRIGGER     �   CREATE TRIGGER "PREVENT_DELETING_THE_DEFAULT_TAX_CLASS" BEFORE DELETE ON public.tax_class FOR EACH ROW EXECUTE FUNCTION public.prevent_delete_default_tax_class();
 K   DROP TRIGGER "PREVENT_DELETING_THE_DEFAULT_TAX_CLASS" ON public.tax_class;
       public          postgres    false    323    288         �           2620    18840 !   product_image PRODUCT_IMAGE_ADDED    TRIGGER     �   CREATE TRIGGER "PRODUCT_IMAGE_ADDED" AFTER INSERT ON public.product_image FOR EACH ROW EXECUTE FUNCTION public.product_image_insert_trigger();
 <   DROP TRIGGER "PRODUCT_IMAGE_ADDED" ON public.product_image;
       public          postgres    false    326    268         �           2620    18841 #   customer SET_DEFAULT_CUSTOMER_GROUP    TRIGGER     �   CREATE TRIGGER "SET_DEFAULT_CUSTOMER_GROUP" BEFORE INSERT ON public.customer FOR EACH ROW EXECUTE FUNCTION public.set_default_customer_group();
 >   DROP TRIGGER "SET_DEFAULT_CUSTOMER_GROUP" ON public.customer;
       public          postgres    false    237    330         �           2620    18842 6   attribute_option TRIGGER_AFTER_ATTRIBUTE_OPTION_UPDATE    TRIGGER     �   CREATE TRIGGER "TRIGGER_AFTER_ATTRIBUTE_OPTION_UPDATE" AFTER UPDATE ON public.attribute_option FOR EACH ROW EXECUTE FUNCTION public.update_product_attribute_option_value_text();
 Q   DROP TRIGGER "TRIGGER_AFTER_ATTRIBUTE_OPTION_UPDATE" ON public.attribute_option;
       public          postgres    false    217    332         �           2620    18843 6   attribute_option TRIGGER_AFTER_DELETE_ATTRIBUTE_OPTION    TRIGGER     �   CREATE TRIGGER "TRIGGER_AFTER_DELETE_ATTRIBUTE_OPTION" AFTER DELETE ON public.attribute_option FOR EACH ROW EXECUTE FUNCTION public.delete_product_attribute_value_index();
 Q   DROP TRIGGER "TRIGGER_AFTER_DELETE_ATTRIBUTE_OPTION" ON public.attribute_option;
       public          postgres    false    308    217         �           2620    18844 *   order_item TRIGGER_AFTER_INSERT_ORDER_ITEM    TRIGGER     �   CREATE TRIGGER "TRIGGER_AFTER_INSERT_ORDER_ITEM" AFTER INSERT ON public.order_item FOR EACH ROW EXECUTE FUNCTION public.reduce_product_stock_when_order_placed();
 E   DROP TRIGGER "TRIGGER_AFTER_INSERT_ORDER_ITEM" ON public.order_item;
       public          postgres    false    327    252         �           2620    18845 $   product TRIGGER_AFTER_INSERT_PRODUCT    TRIGGER     �   CREATE CONSTRAINT TRIGGER "TRIGGER_AFTER_INSERT_PRODUCT" AFTER INSERT ON public.product DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION public.update_variant_group_visibility();
 ?   DROP TRIGGER "TRIGGER_AFTER_INSERT_PRODUCT" ON public.product;
       public          postgres    false    333    257         �           2620    18847 >   attribute_group_link TRIGGER_AFTER_REMOVE_ATTRIBUTE_FROM_GROUP    TRIGGER     �   CREATE TRIGGER "TRIGGER_AFTER_REMOVE_ATTRIBUTE_FROM_GROUP" AFTER DELETE ON public.attribute_group_link FOR EACH ROW EXECUTE FUNCTION public.remove_attribute_from_group();
 Y   DROP TRIGGER "TRIGGER_AFTER_REMOVE_ATTRIBUTE_FROM_GROUP" ON public.attribute_group_link;
       public          postgres    false    215    328         �           2620    18848 (   attribute TRIGGER_AFTER_UPDATE_ATTRIBUTE    TRIGGER     �   CREATE TRIGGER "TRIGGER_AFTER_UPDATE_ATTRIBUTE" AFTER UPDATE ON public.attribute FOR EACH ROW EXECUTE FUNCTION public.delete_variant_group_after_attribute_type_changed();
 C   DROP TRIGGER "TRIGGER_AFTER_UPDATE_ATTRIBUTE" ON public.attribute;
       public          postgres    false    211    313         �           2620    18849 $   product TRIGGER_PRODUCT_AFTER_UPDATE    TRIGGER     �   CREATE CONSTRAINT TRIGGER "TRIGGER_PRODUCT_AFTER_UPDATE" AFTER UPDATE ON public.product DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE FUNCTION public.update_attribute_index_and_variant_group_visibility();
 ?   DROP TRIGGER "TRIGGER_PRODUCT_AFTER_UPDATE" ON public.product;
       public          postgres    false    331    257         �           2620    18851 8   order TRIGGER_UPDATE_COUPON_USED_TIME_AFTER_CREATE_ORDER    TRIGGER     �   CREATE TRIGGER "TRIGGER_UPDATE_COUPON_USED_TIME_AFTER_CREATE_ORDER" AFTER INSERT ON public."order" FOR EACH ROW EXECUTE FUNCTION public.set_coupon_used_time();
 U   DROP TRIGGER "TRIGGER_UPDATE_COUPON_USED_TIME_AFTER_CREATE_ORDER" ON public."order";
       public          postgres    false    329    247         �           2606    18852 (   variant_group FK_ATTRIBUTE_GROUP_VARIANT    FK CONSTRAINT     �   ALTER TABLE ONLY public.variant_group
    ADD CONSTRAINT "FK_ATTRIBUTE_GROUP_VARIANT" FOREIGN KEY (attribute_group_id) REFERENCES public.attribute_group(attribute_group_id) ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.variant_group DROP CONSTRAINT "FK_ATTRIBUTE_GROUP_VARIANT";
       public          postgres    false    213    3537    294         �           2606    18857 &   attribute_group_link FK_ATTRIBUTE_LINK    FK CONSTRAINT     �   ALTER TABLE ONLY public.attribute_group_link
    ADD CONSTRAINT "FK_ATTRIBUTE_LINK" FOREIGN KEY (attribute_id) REFERENCES public.attribute(attribute_id) ON UPDATE CASCADE ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.attribute_group_link DROP CONSTRAINT "FK_ATTRIBUTE_LINK";
       public          postgres    false    3533    215    211         �           2606    18862 $   attribute_option FK_ATTRIBUTE_OPTION    FK CONSTRAINT     �   ALTER TABLE ONLY public.attribute_option
    ADD CONSTRAINT "FK_ATTRIBUTE_OPTION" FOREIGN KEY (attribute_id) REFERENCES public.attribute(attribute_id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.attribute_option DROP CONSTRAINT "FK_ATTRIBUTE_OPTION";
       public          postgres    false    217    3533    211         �           2606    18867 <   product_attribute_value_index FK_ATTRIBUTE_OPTION_VALUE_LINK    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_attribute_value_index
    ADD CONSTRAINT "FK_ATTRIBUTE_OPTION_VALUE_LINK" FOREIGN KEY (option_id) REFERENCES public.attribute_option(attribute_option_id) ON DELETE CASCADE;
 h   ALTER TABLE ONLY public.product_attribute_value_index DROP CONSTRAINT "FK_ATTRIBUTE_OPTION_VALUE_LINK";
       public          postgres    false    258    217    3548         �           2606    18872 5   product_attribute_value_index FK_ATTRIBUTE_VALUE_LINK    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_attribute_value_index
    ADD CONSTRAINT "FK_ATTRIBUTE_VALUE_LINK" FOREIGN KEY (attribute_id) REFERENCES public.attribute(attribute_id) ON DELETE CASCADE;
 a   ALTER TABLE ONLY public.product_attribute_value_index DROP CONSTRAINT "FK_ATTRIBUTE_VALUE_LINK";
       public          postgres    false    258    211    3533         �           2606    18877 '   variant_group FK_ATTRIBUTE_VARIANT_FIVE    FK CONSTRAINT     �   ALTER TABLE ONLY public.variant_group
    ADD CONSTRAINT "FK_ATTRIBUTE_VARIANT_FIVE" FOREIGN KEY (attribute_five) REFERENCES public.attribute(attribute_id) ON DELETE CASCADE;
 S   ALTER TABLE ONLY public.variant_group DROP CONSTRAINT "FK_ATTRIBUTE_VARIANT_FIVE";
       public          postgres    false    211    294    3533         �           2606    18882 '   variant_group FK_ATTRIBUTE_VARIANT_FOUR    FK CONSTRAINT     �   ALTER TABLE ONLY public.variant_group
    ADD CONSTRAINT "FK_ATTRIBUTE_VARIANT_FOUR" FOREIGN KEY (attribute_four) REFERENCES public.attribute(attribute_id) ON DELETE CASCADE;
 S   ALTER TABLE ONLY public.variant_group DROP CONSTRAINT "FK_ATTRIBUTE_VARIANT_FOUR";
       public          postgres    false    294    3533    211         �           2606    18887 &   variant_group FK_ATTRIBUTE_VARIANT_ONE    FK CONSTRAINT     �   ALTER TABLE ONLY public.variant_group
    ADD CONSTRAINT "FK_ATTRIBUTE_VARIANT_ONE" FOREIGN KEY (attribute_one) REFERENCES public.attribute(attribute_id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.variant_group DROP CONSTRAINT "FK_ATTRIBUTE_VARIANT_ONE";
       public          postgres    false    211    3533    294         �           2606    18892 (   variant_group FK_ATTRIBUTE_VARIANT_THREE    FK CONSTRAINT     �   ALTER TABLE ONLY public.variant_group
    ADD CONSTRAINT "FK_ATTRIBUTE_VARIANT_THREE" FOREIGN KEY (attribute_three) REFERENCES public.attribute(attribute_id) ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.variant_group DROP CONSTRAINT "FK_ATTRIBUTE_VARIANT_THREE";
       public          postgres    false    294    3533    211         �           2606    18897 &   variant_group FK_ATTRIBUTE_VARIANT_TWO    FK CONSTRAINT     �   ALTER TABLE ONLY public.variant_group
    ADD CONSTRAINT "FK_ATTRIBUTE_VARIANT_TWO" FOREIGN KEY (attribute_two) REFERENCES public.attribute(attribute_id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.variant_group DROP CONSTRAINT "FK_ATTRIBUTE_VARIANT_TWO";
       public          postgres    false    294    211    3533         �           2606    18902    cart_item FK_CART_ITEM    FK CONSTRAINT     �   ALTER TABLE ONLY public.cart_item
    ADD CONSTRAINT "FK_CART_ITEM" FOREIGN KEY (cart_id) REFERENCES public.cart(cart_id) ON UPDATE CASCADE ON DELETE CASCADE;
 B   ALTER TABLE ONLY public.cart_item DROP CONSTRAINT "FK_CART_ITEM";
       public          postgres    false    223    219    3553         �           2606    18907    cart_item FK_CART_ITEM_PRODUCT    FK CONSTRAINT     �   ALTER TABLE ONLY public.cart_item
    ADD CONSTRAINT "FK_CART_ITEM_PRODUCT" FOREIGN KEY (product_id) REFERENCES public.product(product_id) ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.cart_item DROP CONSTRAINT "FK_CART_ITEM_PRODUCT";
       public          postgres    false    3654    223    257         �           2606    18912    cart FK_CART_SHIPPING_ZONE    FK CONSTRAINT     �   ALTER TABLE ONLY public.cart
    ADD CONSTRAINT "FK_CART_SHIPPING_ZONE" FOREIGN KEY (shipping_zone_id) REFERENCES public.shipping_zone(shipping_zone_id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.cart DROP CONSTRAINT "FK_CART_SHIPPING_ZONE";
       public          postgres    false    219    282    3718         �           2606    18917 ,   category_description FK_CATEGORY_DESCRIPTION    FK CONSTRAINT     �   ALTER TABLE ONLY public.category_description
    ADD CONSTRAINT "FK_CATEGORY_DESCRIPTION" FOREIGN KEY (category_description_category_id) REFERENCES public.category(category_id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.category_description DROP CONSTRAINT "FK_CATEGORY_DESCRIPTION";
       public          postgres    false    3567    225    227         �           2606    18922 ,   cms_page_description FK_CMS_PAGE_DESCRIPTION    FK CONSTRAINT     �   ALTER TABLE ONLY public.cms_page_description
    ADD CONSTRAINT "FK_CMS_PAGE_DESCRIPTION" FOREIGN KEY (cms_page_description_cms_page_id) REFERENCES public.cms_page(cms_page_id) ON UPDATE CASCADE ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.cms_page_description DROP CONSTRAINT "FK_CMS_PAGE_DESCRIPTION";
       public          postgres    false    3578    229    231         �           2606    18927 -   product_collection FK_COLLECTION_PRODUCT_LINK    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_collection
    ADD CONSTRAINT "FK_COLLECTION_PRODUCT_LINK" FOREIGN KEY (collection_id) REFERENCES public.collection(collection_id) ON DELETE CASCADE;
 Y   ALTER TABLE ONLY public.product_collection DROP CONSTRAINT "FK_COLLECTION_PRODUCT_LINK";
       public          postgres    false    3591    233    260         �           2606    18932 $   customer_address FK_CUSTOMER_ADDRESS    FK CONSTRAINT     �   ALTER TABLE ONLY public.customer_address
    ADD CONSTRAINT "FK_CUSTOMER_ADDRESS" FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.customer_address DROP CONSTRAINT "FK_CUSTOMER_ADDRESS";
       public          postgres    false    238    3604    237         �           2606    18937    customer FK_CUSTOMER_GROUP    FK CONSTRAINT     �   ALTER TABLE ONLY public.customer
    ADD CONSTRAINT "FK_CUSTOMER_GROUP" FOREIGN KEY (group_id) REFERENCES public.customer_group(customer_group_id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.customer DROP CONSTRAINT "FK_CUSTOMER_GROUP";
       public          postgres    false    237    3611    241         �           2606    18942 2   product_custom_option_value FK_CUSTOM_OPTION_VALUE    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_custom_option_value
    ADD CONSTRAINT "FK_CUSTOM_OPTION_VALUE" FOREIGN KEY (option_id) REFERENCES public.product_custom_option(product_custom_option_id) ON DELETE CASCADE;
 ^   ALTER TABLE ONLY public.product_custom_option_value DROP CONSTRAINT "FK_CUSTOM_OPTION_VALUE";
       public          postgres    false    3672    264    262         �           2606    18947 "   attribute_group_link FK_GROUP_LINK    FK CONSTRAINT     �   ALTER TABLE ONLY public.attribute_group_link
    ADD CONSTRAINT "FK_GROUP_LINK" FOREIGN KEY (group_id) REFERENCES public.attribute_group(attribute_group_id) ON DELETE CASCADE;
 N   ALTER TABLE ONLY public.attribute_group_link DROP CONSTRAINT "FK_GROUP_LINK";
       public          postgres    false    3537    215    213         �           2606    18952 #   shipping_zone_method FK_METHOD_ZONE    FK CONSTRAINT     �   ALTER TABLE ONLY public.shipping_zone_method
    ADD CONSTRAINT "FK_METHOD_ZONE" FOREIGN KEY (method_id) REFERENCES public.shipping_method(shipping_method_id) ON DELETE CASCADE;
 O   ALTER TABLE ONLY public.shipping_zone_method DROP CONSTRAINT "FK_METHOD_ZONE";
       public          postgres    false    280    3714    283         �           2606    18957    order_item FK_ORDER    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT "FK_ORDER" FOREIGN KEY (order_item_order_id) REFERENCES public."order"(order_id) ON DELETE CASCADE;
 ?   ALTER TABLE ONLY public.order_item DROP CONSTRAINT "FK_ORDER";
       public          postgres    false    247    3625    252         �           2606    18962     order_activity FK_ORDER_ACTIVITY    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_activity
    ADD CONSTRAINT "FK_ORDER_ACTIVITY" FOREIGN KEY (order_activity_order_id) REFERENCES public."order"(order_id) ON DELETE CASCADE;
 L   ALTER TABLE ONLY public.order_activity DROP CONSTRAINT "FK_ORDER_ACTIVITY";
       public          postgres    false    247    248    3625         �           2606    18967    shipment FK_ORDER_SHIPMENT    FK CONSTRAINT     �   ALTER TABLE ONLY public.shipment
    ADD CONSTRAINT "FK_ORDER_SHIPMENT" FOREIGN KEY (shipment_order_id) REFERENCES public."order"(order_id) ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.shipment DROP CONSTRAINT "FK_ORDER_SHIPMENT";
       public          postgres    false    278    247    3625         �           2606    18972 0   payment_transaction FK_PAYMENT_TRANSACTION_ORDER    FK CONSTRAINT     �   ALTER TABLE ONLY public.payment_transaction
    ADD CONSTRAINT "FK_PAYMENT_TRANSACTION_ORDER" FOREIGN KEY (payment_transaction_order_id) REFERENCES public."order"(order_id) ON UPDATE CASCADE ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.payment_transaction DROP CONSTRAINT "FK_PAYMENT_TRANSACTION_ORDER";
       public          postgres    false    247    3625    255         �           2606    18977 "   product FK_PRODUCT_ATTRIBUTE_GROUP    FK CONSTRAINT     �   ALTER TABLE ONLY public.product
    ADD CONSTRAINT "FK_PRODUCT_ATTRIBUTE_GROUP" FOREIGN KEY (group_id) REFERENCES public.attribute_group(attribute_group_id) ON DELETE SET NULL;
 N   ALTER TABLE ONLY public.product DROP CONSTRAINT "FK_PRODUCT_ATTRIBUTE_GROUP";
       public          postgres    false    213    3537    257         �           2606    18982 7   product_attribute_value_index FK_PRODUCT_ATTRIBUTE_LINK    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_attribute_value_index
    ADD CONSTRAINT "FK_PRODUCT_ATTRIBUTE_LINK" FOREIGN KEY (product_id) REFERENCES public.product(product_id) ON DELETE CASCADE;
 c   ALTER TABLE ONLY public.product_attribute_value_index DROP CONSTRAINT "FK_PRODUCT_ATTRIBUTE_LINK";
       public          postgres    false    258    3654    257         �           2606    18987 -   product_collection FK_PRODUCT_COLLECTION_LINK    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_collection
    ADD CONSTRAINT "FK_PRODUCT_COLLECTION_LINK" FOREIGN KEY (product_id) REFERENCES public.product(product_id) ON DELETE CASCADE;
 Y   ALTER TABLE ONLY public.product_collection DROP CONSTRAINT "FK_PRODUCT_COLLECTION_LINK";
       public          postgres    false    260    3654    257         �           2606    18992 .   product_custom_option FK_PRODUCT_CUSTOM_OPTION    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_custom_option
    ADD CONSTRAINT "FK_PRODUCT_CUSTOM_OPTION" FOREIGN KEY (product_custom_option_product_id) REFERENCES public.product(product_id) ON DELETE CASCADE;
 Z   ALTER TABLE ONLY public.product_custom_option DROP CONSTRAINT "FK_PRODUCT_CUSTOM_OPTION";
       public          postgres    false    257    3654    262         �           2606    18997 *   product_description FK_PRODUCT_DESCRIPTION    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_description
    ADD CONSTRAINT "FK_PRODUCT_DESCRIPTION" FOREIGN KEY (product_description_product_id) REFERENCES public.product(product_id) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.product_description DROP CONSTRAINT "FK_PRODUCT_DESCRIPTION";
       public          postgres    false    3654    266    257         �           2606    19002 #   product_image FK_PRODUCT_IMAGE_LINK    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_image
    ADD CONSTRAINT "FK_PRODUCT_IMAGE_LINK" FOREIGN KEY (product_image_product_id) REFERENCES public.product(product_id) ON DELETE CASCADE;
 O   ALTER TABLE ONLY public.product_image DROP CONSTRAINT "FK_PRODUCT_IMAGE_LINK";
       public          postgres    false    257    3654    268         �           2606    19007     product FK_PRODUCT_VARIANT_GROUP    FK CONSTRAINT     �   ALTER TABLE ONLY public.product
    ADD CONSTRAINT "FK_PRODUCT_VARIANT_GROUP" FOREIGN KEY (variant_group_id) REFERENCES public.variant_group(variant_group_id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.product DROP CONSTRAINT "FK_PRODUCT_VARIANT_GROUP";
       public          postgres    false    257    3755    294         �           2606    19012 5   reset_password_token FK_RESET_PASSWORD_TOKEN_CUSTOMER    FK CONSTRAINT     �   ALTER TABLE ONLY public.reset_password_token
    ADD CONSTRAINT "FK_RESET_PASSWORD_TOKEN_CUSTOMER" FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id) ON DELETE CASCADE;
 a   ALTER TABLE ONLY public.reset_password_token DROP CONSTRAINT "FK_RESET_PASSWORD_TOKEN_CUSTOMER";
       public          postgres    false    273    3604    237         �           2606    19017 0   shipping_zone_province FK_SHIPPING_ZONE_PROVINCE    FK CONSTRAINT     �   ALTER TABLE ONLY public.shipping_zone_province
    ADD CONSTRAINT "FK_SHIPPING_ZONE_PROVINCE" FOREIGN KEY (zone_id) REFERENCES public.shipping_zone(shipping_zone_id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.shipping_zone_province DROP CONSTRAINT "FK_SHIPPING_ZONE_PROVINCE";
       public          postgres    false    282    285    3718         �           2606    19022    product FK_TAX_CLASS    FK CONSTRAINT     �   ALTER TABLE ONLY public.product
    ADD CONSTRAINT "FK_TAX_CLASS" FOREIGN KEY (tax_class) REFERENCES public.tax_class(tax_class_id) ON DELETE SET NULL;
 @   ALTER TABLE ONLY public.product DROP CONSTRAINT "FK_TAX_CLASS";
       public          postgres    false    257    288    3735         �           2606    19027    tax_rate FK_TAX_RATE_TAX_CLASS    FK CONSTRAINT     �   ALTER TABLE ONLY public.tax_rate
    ADD CONSTRAINT "FK_TAX_RATE_TAX_CLASS" FOREIGN KEY (tax_class_id) REFERENCES public.tax_class(tax_class_id) ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.tax_rate DROP CONSTRAINT "FK_TAX_RATE_TAX_CLASS";
       public          postgres    false    288    3735    290         �           2606    19032 #   shipping_zone_method FK_ZONE_METHOD    FK CONSTRAINT     �   ALTER TABLE ONLY public.shipping_zone_method
    ADD CONSTRAINT "FK_ZONE_METHOD" FOREIGN KEY (zone_id) REFERENCES public.shipping_zone(shipping_zone_id) ON DELETE CASCADE;
 O   ALTER TABLE ONLY public.shipping_zone_method DROP CONSTRAINT "FK_ZONE_METHOD";
       public          postgres    false    3718    282    283         �           2606    19037 &   product PRODUCT_CATEGORY_ID_CONSTRAINT    FK CONSTRAINT     �   ALTER TABLE ONLY public.product
    ADD CONSTRAINT "PRODUCT_CATEGORY_ID_CONSTRAINT" FOREIGN KEY (category_id) REFERENCES public.category(category_id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.product DROP CONSTRAINT "PRODUCT_CATEGORY_ID_CONSTRAINT";
       public          postgres    false    225    257    3567         �           2606    19042 =   product_inventory PRODUCT_INVENTORY_PRODUCT_ID_CONSTANTSRAINT    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_inventory
    ADD CONSTRAINT "PRODUCT_INVENTORY_PRODUCT_ID_CONSTANTSRAINT" FOREIGN KEY (product_inventory_product_id) REFERENCES public.product(product_id) ON DELETE CASCADE;
 i   ALTER TABLE ONLY public.product_inventory DROP CONSTRAINT "PRODUCT_INVENTORY_PRODUCT_ID_CONSTANTSRAINT";
       public          postgres    false    270    3654    257                                                                                                                                                                                                                                                                                                                                                                                        3962.dat                                                                                            0000600 0004000 0002000 00000000303 14623344605 0014260 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	83dd4b4f-80f0-4ada-ac6f-cfeb54bb3b84	t	admin@admin.com	$2a$10$x/ipHWVu50DEg/Fe/U8hvOjqqcYhpZDnE9KHDdYLTPKRH3xNzm8am	sagar	2024-05-03 16:38:54.581754+05:30	2024-05-03 16:38:54.581754+05:30
\.


                                                                                                                                                                                                                                                                                                                             3964.dat                                                                                            0000600 0004000 0002000 00000000207 14623344605 0014265 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	93b65a8d-07f5-460e-9306-87f4d72b62b0	color	Color	select	f	t	0	t
2	75e892bb-ddf4-42e5-87cd-cbf901a1be7b	size	Size	select	f	t	0	t
\.


                                                                                                                                                                                                                                                                                                                                                                                         3966.dat                                                                                            0000600 0004000 0002000 00000000166 14623344605 0014273 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	a7e541f1-3072-4cba-a460-023765dfe810	Default	2024-05-03 16:39:36.326688+05:30	2024-05-03 16:39:36.326688+05:30
\.


                                                                                                                                                                                                                                                                                                                                                                                                          3968.dat                                                                                            0000600 0004000 0002000 00000000021 14623344605 0014263 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	1	1
2	2	1
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               3970.dat                                                                                            0000600 0004000 0002000 00000000471 14623344605 0014265 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	fef06327-1d9a-4e51-bec3-840930fdee43	1	color	White
2	1367cfdf-953c-4cc8-b2ae-3da7cb3a8b2f	1	color	Black
3	a0915ed8-e40c-44a9-80c1-d998da3630c3	1	color	Yellow
4	865fe925-1659-44d8-afb4-373dfe8526db	2	size	XXL
5	15d51506-9604-407c-9a85-2a5b0ae72d2f	2	size	XL
6	06c97973-66f6-4363-80d5-97453fb3cf6f	2	size	SM
\.


                                                                                                                                                                                                       3972.dat                                                                                            0000600 0004000 0002000 00000005176 14623344605 0014276 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        6	4d221bc6-2782-4540-a8f8-0bfef80232ae	6O_oNr8vdMUGvxT49z2lv_s7NHPjJRSR	USD	\N	\N	\N	\N	\N	t	\N	0.0000	0.0000	0.0000	135.0000	135.0000	3	135.0000	0.0000	135.0000	\N	\N	\N	\N	\N	\N	\N	\N	2024-05-13 11:46:58.221981+05:30	2024-05-13 11:46:58.221981+05:30
1	abe7bc55-14c7-4f28-9a08-e053ac1964d9	qTnydMGMeHxaYPq97rH2JwBpKPgOK6lm	USD	\N	\N	admin@gmail.com	\N	\N	t	\N	0.0000	0.0000	0.0000	45.0000	45.0000	1	45.0000	0.0000	45.0000	\N	\N	\N	\N	\N	\N	\N	\N	2024-05-11 09:53:52.909194+05:30	2024-05-11 09:53:52.909194+05:30
3	5e0b64bf-7c02-42c6-a1d0-a584ac54f8d4	HNm5jhTLQuqNsAB1nmoPiWP5PEnD7gkw	USD	\N	\N	admin@gmail.com	\N	\N	t	\N	0.0000	0.0000	0.0000	38.0000	38.0000	1	38.0000	0.0000	38.0000	\N	\N	1	3	\N	\N	\N	\N	2024-05-11 15:22:34.8123+05:30	2024-05-11 15:22:34.8123+05:30
2	8730cd6c-5c7b-4965-a62d-83bcb3202f80	9TibCa1uDMD7w9c3Ig04-XnWFv45UIFY	USD	\N	\N	admin@gmail.com	\N	\N	t	\N	0.0000	0.0000	0.0000	242.0000	242.0000	6	242.0000	0.0000	242.0000	\N	\N	1	5	\N	\N	\N	\N	2024-05-11 12:54:45.732963+05:30	2024-05-11 12:54:45.732963+05:30
4	94d4e20f-87dc-4570-94a5-c77826822496	eMl89y0HURrLHCPFJl86mxhK9Dikerq8	USD	\N	\N	admin@gmail.com	\N	\N	t	EVER100	0.0000	0.0000	15.0000	1063.0000	1063.0000	24	1053.0000	0.0000	1048.0000	\N	\N	1	11	\N	\N	\N	\N	2024-05-13 10:46:54.66152+05:30	2024-05-13 10:46:54.66152+05:30
7	32029383-9809-4f55-a123-b53db1635eeb	bys16sQrE-Uo6arVag8QYER43Fkmh_f2	USD	\N	\N	admin@gmail.com	\N	\N	f	\N	20.0000	20.0000	0.0000	30.0000	30.0000	1	30.0000	0.0000	50.0000	5a0d1c74-3a6f-4b55-9881-cf57c662487a	Express	1	12	cod	Cash On Delivery	13	\N	2024-05-15 14:55:46.472288+05:30	2024-05-15 14:55:46.472288+05:30
8	a42fb3f8-d00f-4704-a198-30fc96d53213	bys16sQrE-Uo6arVag8QYER43Fkmh_f2	USD	\N	\N	admin@gmail.com	\N	\N	f	\N	20.0000	20.0000	0.0000	30.0000	30.0000	1	30.0000	0.0000	50.0000	5a0d1c74-3a6f-4b55-9881-cf57c662487a	Express	1	14	cod	Cash On Delivery	15	\N	2024-05-15 16:15:52.517924+05:30	2024-05-15 16:15:52.517924+05:30
9	9758cd32-7f30-41f3-a296-fcc287270c9a	G1DTDK9FRQNlxuGhlaIlrc3RNFFVJDB9	USD	\N	\N	\N	\N	\N	t	\N	0.0000	0.0000	0.0000	30.0000	30.0000	1	30.0000	0.0000	30.0000	\N	\N	\N	\N	\N	\N	\N	\N	2024-05-16 16:40:43.056042+05:30	2024-05-16 16:40:43.056042+05:30
5	c1bfc828-7fe1-457a-a56b-7a84f9b4855c	qth-TQBK2_ny06o2lhi1GnwXTVahFQat	USD	\N	\N	\N	\N	\N	t	\N	0.0000	0.0000	0.0000	45.0000	45.0000	1	45.0000	0.0000	45.0000	\N	\N	\N	\N	\N	\N	\N	\N	2024-05-13 11:46:01.693836+05:30	2024-05-13 11:46:01.693836+05:30
10	165e225d-eba2-4af1-80df-7b1ccf4bfef9	DXgbi_VvYK97hQl-axUU0vBB0dLXux21	USD	\N	\N	\N	\N	\N	t	\N	0.0000	0.0000	0.0000	15.0000	15.0000	1	15.0000	0.0000	15.0000	\N	\N	\N	\N	\N	\N	\N	\N	2024-05-22 14:59:31.300677+05:30	2024-05-22 14:59:31.300677+05:30
\.


                                                                                                                                                                                                                                                                                                                                                                                                  3973.dat                                                                                            0000600 0004000 0002000 00000004426 14623344605 0014274 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	c38e1e30-4da3-47cc-a9ea-914b49b6db22	admin	395017	09191919191	IN	IN-GJ	Surat	47, Hasmukhbhai Hojwala Rd, Yogikrupa Society, Bhatar, Athwa, Surat, Gujarat 395017, India	\N
2	358bfd9d-c988-45c8-a002-b93cbd27ed8e	admin	395017	09191919191	IN	IN-GJ	Surat	47, Hasmukhbhai Hojwala Rd, Yogikrupa Society, Bhatar, Athwa, Surat, Gujarat 395017, India	\N
3	ce177422-2a42-4a6b-bb4e-8b35b2929ce1	muken	395010	7589633215	IN	IN-GJ	surat	75 velly road laskana 	\N
4	8184a91d-953c-4df2-927b-9db469c40343	admin	395017	09191919191	IN	IN-GJ	Surat	47, Hasmukhbhai Hojwala Rd, Yogikrupa Society, Bhatar, Athwa, Surat, Gujarat 395017, India	\N
5	48c1723b-246e-4fae-b7d7-fd130f08a8a2	admin	395017	09191919191	IN	IN-GJ	Surat	47, Hasmukhbhai Hojwala Rd, Yogikrupa Society, Bhatar, Athwa, Surat, Gujarat 395017, India	\N
6	751e6e00-1f09-4646-a1ee-50bc1dc2adf6	admin	395017	09191919191	IN	IN-GJ	Surat	16-18, 16-18, Udhana - Magdalla Rd, Police Colony, Gandhi Kutir, Surat, Gujarat 395017, India	\N
7	535533f1-46e3-426a-ac16-53b9ba747397	admin	395017	09191919191	IN	IN-GJ	Surat	16-18, 16-18, Udhana - Magdalla Rd, Police Colony, Gandhi Kutir, Surat, Gujarat 395017, India	\N
8	5594ca34-1304-4d41-bd7d-1219d08dc233	admin	395017	09191919191	IN	IN-GJ	Surat	16-18, 16-18, Udhana - Magdalla Rd, Police Colony, Gandhi Kutir, Surat, Gujarat 395017, India	\N
9	499c3c3f-027d-449c-a44d-3a94b9b5d02e	admin	395017	09191919191	IN	IN-GJ	Surat	16-18, 16-18, Udhana - Magdalla Rd, Police Colony, Gandhi Kutir, Surat, Gujarat 395017, India	\N
10	a6fb1219-a242-48ca-8335-7f40386aa092	admin	395017	09191919191	IN	IN-GJ	Surat	16-18, 16-18, Udhana - Magdalla Rd, Police Colony, Gandhi Kutir, Surat, Gujarat 395017, India	\N
11	1724be7f-b7e7-4651-8968-41393734b82a	hesd	395017	7894561230	IN	IN-GJ	Surat	Magdalla Rd, Police Colony, Gandhi Kutir, Surat, Gujarat 395017, India	\N
12	6e2d10d2-eac4-4ebc-a237-4057674678c1	admin	395009	09191919191	IN	IN-GJ	Surat	varacha	\N
13	92177df3-d301-460d-9788-084138ece617	admin	395009	09191919191	IN	IN-GJ	Surat	varacha	\N
14	5103a9b6-de5f-4e14-8344-fa81dd882f52	admin	395017	09191919191	IN	IN-GJ	Surat	 Magdalla Rd, Police Colony, Gandhi Kutir, Surat, Gujarat 395017, India	\N
15	40f00b07-abc6-47e3-a0ec-9d6a6767e84a	admin	395017	09191919191	IN	IN-GJ	Surat	 Magdalla Rd, Police Colony, Gandhi Kutir, Surat, Gujarat 395017, India	\N
\.


                                                                                                                                                                                                                                          3976.dat                                                                                            0000600 0004000 0002000 00000003601 14623344605 0014271 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        13	8729e071-14ab-4de7-809b-ba28e657c209	8	36	17	Comfy H Massage Chair	/assets/catalog/4795/7235/products-eight-thumb.png	30.0000	30.0000	30.0000	1	30.0000	30.0000	0.0000	0.0000	0.0000	30.0000	30.0000	5	[{"attribute_code":"color","attribute_name":"Color","attribute_id":1,"option_id":3,"option_text":"Yellow"},{"attribute_code":"size","attribute_name":"Size","attribute_id":2,"option_id":5,"option_text":"XL"}]	\N	2024-05-15 16:15:52.517924+05:30	2024-05-15 16:15:52.517924+05:30
14	e2213b3f-9dab-4fdb-93c0-8f7e87cab101	9	35	12	Comfy H Massage Chair	/assets/catalog/1360/8670/products-two-thumb.png	30.0000	30.0000	30.0000	1	30.0000	30.0000	0.0000	0.0000	0.0000	30.0000	30.0000	5	[{"attribute_code":"color","attribute_name":"Color","attribute_id":1,"option_id":2,"option_text":"Black"},{"attribute_code":"size","attribute_name":"Size","attribute_id":2,"option_id":4,"option_text":"XXL"}]	\N	2024-05-16 16:40:43.056042+05:30	2024-05-16 16:40:43.056042+05:30
12	b8d00670-c845-4a19-9b3b-e5e2a6b617e2	7	36	17	Comfy H Massage Chair	/assets/catalog/4795/7235/products-eight-thumb.png	30.0000	30.0000	30.0000	1	30.0000	30.0000	0.0000	0.0000	0.0000	30.0000	30.0000	5	[{"attribute_code":"color","attribute_name":"Color","attribute_id":1,"option_id":3,"option_text":"Yellow"},{"attribute_code":"size","attribute_name":"Size","attribute_id":2,"option_id":5,"option_text":"XL"}]	\N	2024-05-15 14:55:46.472288+05:30	2024-05-15 14:55:46.472288+05:30
15	3417c0b6-d6c5-448c-b409-3af729d365d0	10	34	11	Gold Glory Massage Chair	/assets/catalog/4335/2497/products-one-thumb.png	15.0000	15.0000	15.0000	1	15.0000	15.0000	0.0000	0.0000	0.0000	15.0000	15.0000	4	[{"attribute_code":"color","attribute_name":"Color","attribute_id":1,"option_id":3,"option_text":"Yellow"},{"attribute_code":"size","attribute_name":"Size","attribute_id":2,"option_id":5,"option_text":"XL"}]	\N	2024-05-22 14:59:31.300677+05:30	2024-05-22 14:59:31.300677+05:30
\.


                                                                                                                               3978.dat                                                                                            0000600 0004000 0002000 00000001643 14623344605 0014277 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        18	4eef8f7e-253c-4616-afec-4ec6a070aa35	t	\N	t	\N	2024-05-14 10:59:19.481637+05:30	2024-05-14 10:59:19.481637+05:30
19	d2d26cdc-9153-4c2b-99d9-045939906fb1	t	\N	t	\N	2024-05-14 11:00:10.874002+05:30	2024-05-14 11:00:10.874002+05:30
20	9a673b3b-c251-4d8e-ac29-63c8c324dade	t	\N	t	\N	2024-05-14 11:00:43.564976+05:30	2024-05-14 11:00:43.564976+05:30
21	1166da0a-eb0c-4b4f-8d9c-0d452276eab9	t	\N	t	\N	2024-05-14 11:01:22.523078+05:30	2024-05-14 11:01:22.523078+05:30
22	c0d95aea-166c-4b18-91b2-de23193c1b95	t	\N	t	\N	2024-05-14 11:01:55.324314+05:30	2024-05-14 11:01:55.324314+05:30
23	71dcc6a9-defd-4b86-bcef-10dffeadd4a8	t	\N	t	\N	2024-05-14 11:02:26.904305+05:30	2024-05-14 11:02:26.904305+05:30
24	84de9de7-2f96-4208-b839-a2cd13ae4e18	t	\N	t	\N	2024-05-14 11:03:03.65523+05:30	2024-05-14 11:03:03.65523+05:30
25	b6b17ee3-980c-4ed0-bf1a-7da8b8fd26d9	t	\N	t	\N	2024-05-14 11:03:38.359129+05:30	2024-05-14 11:03:38.359129+05:30
\.


                                                                                             3980.dat                                                                                            0000600 0004000 0002000 00000001210 14623344605 0014256 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        25	25	Massage Chair	\N			Massage Chair	Massage Chair	Massage Chair	massage-chair
18	18	Corporate Gifts	\N			Corporate Gifts		Corporate Gifts	corporate-gifts
19	19	New Arrivals	\N			New Arrivals		New Arrivals	new-arrivals
20	20	Gym Products	\N			Gym Products		Gym Products	gym-products
21	21	Salon Spa Jacuzzi	\N			Salon Spa Jacuzzi		Salon Spa Jacuzzi	salon-spa-jacuzzi
22	22	Foot & Leg Massager	\N			Foot & Leg Massager		Foot & Leg Massager	foot-leg-massager
23	23	Thermal Heating Hat	\N			Thermal Heating Hat		Thermal Heating Hat	thermal-heating-hat
24	24	Thermal Heating Bed	\N			Thermal Heating Bed		Thermal Heating Bed	thermal-heating-bed
\.


                                                                                                                                                                                                                                                                                                                                                                                        3982.dat                                                                                            0000600 0004000 0002000 00000001470 14623344605 0014270 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        2	e22b729b-0ede-4161-8b69-97cf1525ec7f	oneColumn	t	2024-05-10 10:33:50.788346+05:30	2024-05-10 10:33:50.788346+05:30
3	7a53b5fa-240c-4dd5-a770-aedb6662a9f0	oneColumn	t	2024-05-10 12:45:42.086008+05:30	2024-05-10 12:45:42.086008+05:30
4	880e0df0-0cc2-4dcf-b2bb-e648dc92be9a	oneColumn	t	2024-05-10 12:50:57.700592+05:30	2024-05-10 12:50:57.700592+05:30
5	e8e52484-e075-4d8b-a4dc-8d1a994f7f15	oneColumn	t	2024-05-10 12:53:36.693949+05:30	2024-05-10 12:53:36.693949+05:30
6	322d0925-5a76-4861-a092-6650a4bde200	oneColumn	t	2024-05-10 12:56:38.782256+05:30	2024-05-10 12:56:38.782256+05:30
7	3f60ca2e-9034-4a41-b453-4dd30d5b7624	oneColumn	t	2024-05-10 14:00:43.007138+05:30	2024-05-10 14:00:43.007138+05:30
8	6d7614d4-623d-4a66-b47a-dc4f1edf2dfc	oneColumn	t	2024-05-10 14:19:03.228662+05:30	2024-05-10 14:19:03.228662+05:30
\.


                                                                                                                                                                                                        3984.dat                                                                                            0000600 0004000 0002000 00000000433 14623344605 0014270 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        2	2	privacy-policy	privacy-policy				
3	3	terms-conditions	terms-conditions				
4	4	shipping-policy	shipping-policy				
5	5	refund-policy	refund-policy				
6	6	contact-us	contact-us				
7	7	corporate-gifts	corporate-gifts				
8	8	franchise-opportunity	franchise-opportunity				
\.


                                                                                                                                                                                                                                     3986.dat                                                                                            0000600 0004000 0002000 00000000415 14623344605 0014272 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        3	61791440-1b3f-43ec-b574-7b2e3c010d2b	Featured Products		homepage	2024-05-16 11:48:07.80786+05:30	2024-05-16 11:48:07.80786+05:30
6	e6bd7de3-ec4d-4874-b42d-6ef0134a8996	Home Slider		homepageslider	2024-05-16 15:13:51.487792+05:30	2024-05-16 15:13:51.487792+05:30
\.


                                                                                                                                                                                                                                                   3988.dat                                                                                            0000600 0004000 0002000 00000000475 14623344605 0014302 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	dc5d18d1-9e61-426c-80e1-f0896584ad8c	t	Demo	15.0000	t	fixed_discount_to_entire_order	EVER100	0	\N	{"order_qty": "", "order_total": ""}	{"emails": "", "groups": [""], "purchased": ""}	\N	\N	\N	2024-05-13 05:30:00+05:30	2024-05-31 05:30:00+05:30	2024-05-13 12:02:35.864121+05:30	2024-05-13 12:02:35.864121+05:30
\.


                                                                                                                                                                                                   3990.dat                                                                                            0000600 0004000 0002000 00000000304 14623344605 0014262 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	8ebfb0e7-cece-45a0-8294-848d8c2417d0	1	1	123@gmail.com	$2a$10$0q9VZ9AzzFYatO2M9xlUWuiWetrqrqw8.joMsKlHw/6uY/JyR1.ea	sdfsdf	2024-05-08 12:49:16.529868+05:30	2024-05-08 12:49:16.529868+05:30
\.


                                                                                                                                                                                                                                                                                                                            3991.dat                                                                                            0000600 0004000 0002000 00000000005 14623344605 0014261 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3994.dat                                                                                            0000600 0004000 0002000 00000000166 14623344605 0014274 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	7549e598-896e-4645-a78d-d975e297705f	Default	2024-05-03 16:39:43.032693+05:30	2024-05-03 16:39:43.032693+05:30
\.


                                                                                                                                                                                                                                                                                                                                                                                                          3996.dat                                                                                            0000600 0004000 0002000 00000134507 14623344605 0014305 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        71	a4f03261-187d-47a9-9b03-518d8b2ea464	inventory_updated	{"old" : {"product_inventory_id":11,"product_inventory_product_id":12,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":11,"product_inventory_product_id":12,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-10 17:30:28.17368+05:30
195	1e1d9b95-5b28-4d0d-a315-8d87779133f4	inventory_updated	{"old" : {"product_inventory_id":11,"product_inventory_product_id":12,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":11,"product_inventory_product_id":12,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-11 15:06:37.763271+05:30
73	a8c2bccd-5754-42ad-817a-5e95f368201b	inventory_updated	{"old" : {"product_inventory_id":11,"product_inventory_product_id":12,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":11,"product_inventory_product_id":12,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-10 17:30:55.323609+05:30
341	2ac4b173-8536-4c6e-a534-42f23b815557	inventory_updated	{"old" : {"product_inventory_id":5,"product_inventory_product_id":5,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":5,"product_inventory_product_id":5,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-13 12:00:05.649376+05:30
75	57ce0935-5bc3-4c4b-ad93-3bf2eeb953ba	inventory_updated	{"old" : {"product_inventory_id":11,"product_inventory_product_id":12,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":11,"product_inventory_product_id":12,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-10 17:31:22.666799+05:30
206	e8c172eb-aecb-4c3d-8e32-1385d4c9948a	inventory_updated	{"old" : {"product_inventory_id":9,"product_inventory_product_id":10,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":9,"product_inventory_product_id":10,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-11 15:15:33.212329+05:30
8	15075286-1253-4f45-9692-efd729351c9c	customer_created	{"customer_id":1,"uuid":"8ebfb0e7-cece-45a0-8294-848d8c2417d0","status":1,"group_id":1,"email":"123@gmail.com","password":"$2a$10$0q9VZ9AzzFYatO2M9xlUWuiWetrqrqw8.joMsKlHw/6uY/JyR1.ea","full_name":"sdfsdf","created_at":"2024-05-08T07:19:16.529868+00:00","updated_at":"2024-05-08T07:19:16.529868+00:00"}	2024-05-08 12:49:16.529868+05:30
9	21e4a17e-4f4b-4d91-9372-5daaae6f3028	customer_registered	{"customer_id":1,"uuid":"8ebfb0e7-cece-45a0-8294-848d8c2417d0","status":1,"group_id":1,"email":"123@gmail.com","full_name":"sdfsdf","created_at":"2024-05-08T07:19:16.529Z","updated_at":"2024-05-08T07:19:16.529Z","insertId":1}	2024-05-08 12:49:16.840531+05:30
77	50782bf8-3477-4d77-8c24-ed718e72d863	inventory_updated	{"old" : {"product_inventory_id":11,"product_inventory_product_id":12,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":11,"product_inventory_product_id":12,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-10 17:32:03.426828+05:30
28	50b17459-3711-4ddd-83b0-e15a273d299b	inventory_updated	{"old" : {"product_inventory_id":5,"product_inventory_product_id":5,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":5,"product_inventory_product_id":5,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-10 16:23:25.705279+05:30
30	ab9a1bfd-4f5b-4478-8f7e-169a80025967	inventory_updated	{"old" : {"product_inventory_id":5,"product_inventory_product_id":5,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":5,"product_inventory_product_id":5,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-10 16:23:40.029706+05:30
32	e6ef77e0-8e20-4175-bb93-0c25010bf86f	inventory_updated	{"old" : {"product_inventory_id":5,"product_inventory_product_id":5,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":5,"product_inventory_product_id":5,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-10 16:24:25.452456+05:30
34	a91cbc67-4682-4e1f-9f44-0e07d69f62ad	inventory_updated	{"old" : {"product_inventory_id":5,"product_inventory_product_id":5,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":5,"product_inventory_product_id":5,"qty":0,"manage_stock":true,"stock_availability":true}}	2024-05-10 16:25:27.88214+05:30
36	c84efbd3-b213-4379-b7ce-d081612a290b	inventory_updated	{"old" : {"product_inventory_id":5,"product_inventory_product_id":5,"qty":0,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":5,"product_inventory_product_id":5,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-10 16:25:38.70791+05:30
44	90a4ee1d-d6b5-4f84-99d1-0247c1a27c3a	inventory_updated	{"old" : {"product_inventory_id":6,"product_inventory_product_id":6,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":6,"product_inventory_product_id":6,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-10 17:05:21.449329+05:30
51	9509678a-65e9-4b50-8464-7e6a76d62d49	inventory_updated	{"old" : {"product_inventory_id":8,"product_inventory_product_id":9,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":8,"product_inventory_product_id":9,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-10 17:08:41.888449+05:30
59	59a6e6ef-ba35-4bc0-9114-9a1a8d180160	inventory_updated	{"old" : {"product_inventory_id":11,"product_inventory_product_id":12,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":11,"product_inventory_product_id":12,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-10 17:18:04.588662+05:30
61	fa35ae3a-95c8-4ff8-bd7c-0ba088514d0b	inventory_updated	{"old" : {"product_inventory_id":11,"product_inventory_product_id":12,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":11,"product_inventory_product_id":12,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-10 17:27:10.408863+05:30
63	f236310c-5a84-4985-ad73-07620ecbb6fe	inventory_updated	{"old" : {"product_inventory_id":11,"product_inventory_product_id":12,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":11,"product_inventory_product_id":12,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-10 17:27:43.351521+05:30
65	19428dbf-8ddf-40d0-9a07-56dc1c73e9b5	inventory_updated	{"old" : {"product_inventory_id":11,"product_inventory_product_id":12,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":11,"product_inventory_product_id":12,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-10 17:28:19.909894+05:30
67	08a611f3-1913-4fb3-a8b9-711455a01d81	inventory_updated	{"old" : {"product_inventory_id":11,"product_inventory_product_id":12,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":11,"product_inventory_product_id":12,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-10 17:29:03.682299+05:30
69	898324b8-d344-4c45-b1bb-562802da7bcf	inventory_updated	{"old" : {"product_inventory_id":11,"product_inventory_product_id":12,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":11,"product_inventory_product_id":12,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-10 17:29:13.078685+05:30
343	e29eaead-9abd-4459-ac34-e014ef9d53ff	inventory_updated	{"old" : {"product_inventory_id":11,"product_inventory_product_id":12,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":11,"product_inventory_product_id":12,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-13 12:00:08.273188+05:30
345	472fa387-435b-4383-afb8-c428e4385afa	inventory_updated	{"old" : {"product_inventory_id":13,"product_inventory_product_id":15,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":13,"product_inventory_product_id":15,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-13 12:00:14.703664+05:30
288	cce13cad-6792-413e-801f-6734e1cf5a4d	inventory_updated	{"old" : {"product_inventory_id":7,"product_inventory_product_id":7,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":7,"product_inventory_product_id":7,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-11 15:56:40.086151+05:30
347	929f4be8-1175-43a6-be52-ef0f7a553802	inventory_updated	{"old" : {"product_inventory_id":14,"product_inventory_product_id":16,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":14,"product_inventory_product_id":16,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-13 12:00:18.445587+05:30
445	8381659b-0981-437a-92c4-c2da3fa9799b	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 12:56:41.75924+05:30
208	d9f9851d-bf7d-4a47-9682-ee557a0dc809	inventory_updated	{"old" : {"product_inventory_id":9,"product_inventory_product_id":10,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":9,"product_inventory_product_id":10,"qty":10,"manage_stock":true,"stock_availability":true}}	2024-05-11 15:21:08.818462+05:30
349	bf5d0d87-b1ba-4e42-82b9-eebc515f64f3	inventory_updated	{"old" : {"product_inventory_id":15,"product_inventory_product_id":18,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":15,"product_inventory_product_id":18,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-13 12:00:21.84734+05:30
353	910a9717-a7d9-405c-9da4-cb420fa8b85c	inventory_updated	{"old" : {"product_inventory_id":10,"product_inventory_product_id":11,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":10,"product_inventory_product_id":11,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-13 17:26:49.395523+05:30
457	9c444585-bb73-4ec1-860e-92a7dec3d717	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 13:50:24.629041+05:30
359	9644eb61-2e02-4445-8b14-242418ccf671	inventory_updated	{"old" : {"product_inventory_id":10,"product_inventory_product_id":11,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":10,"product_inventory_product_id":11,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-13 17:38:20.852522+05:30
231	beb9d4e4-cd4f-4f57-a24c-06396606ce1f	inventory_updated	{"old" : {"product_inventory_id":10,"product_inventory_product_id":11,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":10,"product_inventory_product_id":11,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-11 15:35:20.482665+05:30
319	cb2d8415-4be2-4119-9359-6efd5d3b6c51	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-13 11:56:49.52642+05:30
471	f8ecd6ad-97d5-4d01-8532-f95ef5800f99	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 14:17:31.862825+05:30
321	d8b6f73c-07d9-4ca9-974b-c7e63a4bcbb4	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-13 11:56:55.135909+05:30
240	708d99ff-f013-48e6-8fdf-0e52f37d6e94	inventory_updated	{"old" : {"product_inventory_id":17,"product_inventory_product_id":22,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":17,"product_inventory_product_id":22,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-11 15:37:09.962255+05:30
327	c61a3bf1-a9c4-4c26-b958-28a46a7d44dc	inventory_updated	{"old" : {"product_inventory_id":23,"product_inventory_product_id":29,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":23,"product_inventory_product_id":29,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-13 11:57:41.671169+05:30
483	b8d5bf7d-82fa-4b00-a8f5-b838dbcec080	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 14:31:07.372916+05:30
333	41336a39-10b6-4eb3-a4bd-21c96ca140d8	inventory_updated	{"old" : {"product_inventory_id":20,"product_inventory_product_id":26,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":20,"product_inventory_product_id":26,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-13 11:58:24.099087+05:30
339	ab37bbb4-fc5f-400c-9f35-ba6fbfcfdb91	inventory_updated	{"old" : {"product_inventory_id":16,"product_inventory_product_id":21,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":16,"product_inventory_product_id":21,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-13 11:59:25.040517+05:30
495	944ff601-d130-49a4-a344-c224d88958e8	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 14:59:06.046041+05:30
507	37b54022-e96c-43fe-a775-9acb54f56581	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-15 10:40:53.183026+05:30
519	6be1043b-a41f-44ad-948f-cb67cbe1dd6f	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-15 11:26:19.572096+05:30
204	dc980e55-fb89-40b2-9eaa-ef8cc57d8c5a	inventory_updated	{"old" : {"product_inventory_id":9,"product_inventory_product_id":10,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":9,"product_inventory_product_id":10,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-11 15:15:01.85332+05:30
545	38739144-c30e-48d4-9e8c-9d7d14006253	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-15 12:56:03.563046+05:30
355	bcd6e711-091b-4470-b28c-90e87a172e71	inventory_updated	{"old" : {"product_inventory_id":10,"product_inventory_product_id":11,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":10,"product_inventory_product_id":11,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-13 17:36:10.862501+05:30
361	75d378ce-22f8-4dc4-a154-e7b398ccc6ad	inventory_updated	{"old" : {"product_inventory_id":10,"product_inventory_product_id":11,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":10,"product_inventory_product_id":11,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-13 17:41:18.276386+05:30
447	146f2614-e752-487c-b291-95e19750f215	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 12:58:38.24297+05:30
459	1a8156a2-6ceb-41a0-9f2b-37e1d368d726	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 13:57:21.696434+05:30
473	10392c03-e1f7-4571-b167-c110b7c66b84	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 14:19:49.87606+05:30
116	d7518f6e-b711-4c38-a4fe-47fc9fdaeed3	inventory_updated	{"old" : {"product_inventory_id":11,"product_inventory_product_id":12,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":11,"product_inventory_product_id":12,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-10 17:53:26.514315+05:30
485	52e347bc-4888-4da7-bb7d-839937d2d86e	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 14:31:54.224408+05:30
118	9907eab1-66d4-491b-a20a-59b6bb30a484	inventory_updated	{"old" : {"product_inventory_id":10,"product_inventory_product_id":11,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":10,"product_inventory_product_id":11,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-10 17:53:36.392254+05:30
120	b54066e1-a34d-45ff-86d4-93cdaaaff87a	inventory_updated	{"old" : {"product_inventory_id":9,"product_inventory_product_id":10,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":9,"product_inventory_product_id":10,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-10 17:53:44.269885+05:30
497	c9cd447d-8272-4058-b6e7-04c847cb6c8c	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 15:00:48.414205+05:30
122	dfbd10f8-31fe-4c6c-bc69-a37cda245baa	inventory_updated	{"old" : {"product_inventory_id":8,"product_inventory_product_id":9,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":8,"product_inventory_product_id":9,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-10 17:54:11.644858+05:30
323	cba2728c-d020-4a3e-bd5f-e97d6065fefb	inventory_updated	{"old" : {"product_inventory_id":25,"product_inventory_product_id":31,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":25,"product_inventory_product_id":31,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-13 11:57:16.525729+05:30
124	25787e46-c6df-44d0-9d5d-2f5df16bd3e3	inventory_updated	{"old" : {"product_inventory_id":7,"product_inventory_product_id":7,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":7,"product_inventory_product_id":7,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-10 17:55:25.653014+05:30
126	be30e288-9a21-4de0-8e90-e2a8507e3c36	inventory_updated	{"old" : {"product_inventory_id":6,"product_inventory_product_id":6,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":6,"product_inventory_product_id":6,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-10 17:56:30.907675+05:30
329	7eec0a4e-1852-4a51-b4b2-aa023e0700c7	inventory_updated	{"old" : {"product_inventory_id":22,"product_inventory_product_id":28,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":22,"product_inventory_product_id":28,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-13 11:57:53.682674+05:30
128	93d61b87-9928-4057-9b90-2681835e95d1	inventory_updated	{"old" : {"product_inventory_id":5,"product_inventory_product_id":5,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":5,"product_inventory_product_id":5,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-10 17:56:39.827935+05:30
509	0c7015d7-cd10-4e2b-8007-f62603cfb067	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-15 10:44:12.414542+05:30
335	4c8f32b5-93af-4bac-99ac-ad5312356d80	inventory_updated	{"old" : {"product_inventory_id":18,"product_inventory_product_id":23,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":18,"product_inventory_product_id":23,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-13 11:58:44.306042+05:30
547	4a617639-c619-4889-ab8f-420bf472766e	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-15 13:51:47.573+05:30
357	691686b1-5917-44a2-b086-91e2584e48bc	inventory_updated	{"old" : {"product_inventory_id":10,"product_inventory_product_id":11,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":10,"product_inventory_product_id":11,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-13 17:36:53.009102+05:30
249	711ce7a6-127e-4465-8ad9-c3ffe120730f	inventory_updated	{"old" : {"product_inventory_id":17,"product_inventory_product_id":22,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":17,"product_inventory_product_id":22,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-11 15:37:56.84203+05:30
363	e2502d45-c6ca-48a8-bff4-901dbfebf314	inventory_updated	{"old" : {"product_inventory_id":10,"product_inventory_product_id":11,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":10,"product_inventory_product_id":11,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-13 17:43:19.578813+05:30
449	d497cab6-64b3-4c25-9864-be4a43bf40aa	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 13:00:45.706171+05:30
461	973632b2-e86e-495c-bb77-558a3ae4c23f	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 14:04:28.096823+05:30
463	3e142c08-c44e-43b8-aa21-5395ca535038	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 14:04:37.300711+05:30
258	2a43972b-a24c-447c-9383-d47dfe70baa9	inventory_updated	{"old" : {"product_inventory_id":8,"product_inventory_product_id":9,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":8,"product_inventory_product_id":9,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-11 15:52:03.778863+05:30
260	3bf7df3c-33d3-4f24-96db-4c5744c16024	inventory_updated	{"old" : {"product_inventory_id":8,"product_inventory_product_id":9,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":8,"product_inventory_product_id":9,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-11 15:52:13.652589+05:30
475	6ab13bdb-9f19-4457-922e-430ceb571a45	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 14:22:14.748801+05:30
487	15cbadb7-402e-4d58-a916-8f29b3db1f6a	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 14:32:34.990421+05:30
312	f28837f8-83ad-4275-a885-db6beef4cf23	inventory_updated	{"old" : {"product_inventory_id":10,"product_inventory_product_id":11,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":10,"product_inventory_product_id":11,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-13 11:56:07.441613+05:30
499	b7effb79-5be6-46e3-b62d-c92f427f8c22	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 15:07:28.893939+05:30
511	3038ad5c-40e1-4384-94b5-48886f17b103	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-15 11:17:39.637454+05:30
521	01653ab5-23c0-4ac3-be3a-cf2b6c1ae9e3	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-15 11:46:05.641221+05:30
529	3f7fe18e-baef-4446-af2c-2c2d109fcc0e	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-15 12:00:24.551488+05:30
325	2544cb28-88af-44d3-a1e9-4dcd9fb0c66c	inventory_updated	{"old" : {"product_inventory_id":24,"product_inventory_product_id":30,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":24,"product_inventory_product_id":30,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-13 11:57:29.488162+05:30
331	ecaac5f5-9b48-4366-a1aa-cc2d690ab81a	inventory_updated	{"old" : {"product_inventory_id":21,"product_inventory_product_id":27,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":21,"product_inventory_product_id":27,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-13 11:58:10.336615+05:30
537	7d2aa252-e11b-4cd6-bd24-9122d55c9877	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-15 12:18:34.923404+05:30
337	368be924-0950-4db5-a299-a0f56209b46d	inventory_updated	{"old" : {"product_inventory_id":17,"product_inventory_product_id":22,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":17,"product_inventory_product_id":22,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-13 11:58:56.804651+05:30
549	361fdb9e-41f9-4deb-b135-71e7007df9fa	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-15 14:23:59.57375+05:30
439	d8bcd561-de3b-450e-8751-b919baf2833e	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 12:47:00.612127+05:30
451	c413c2d6-6969-4431-a398-ced2f022cae1	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 13:41:05.407241+05:30
465	1a75364a-29af-4329-b357-8a0ec69d113f	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 14:12:27.673112+05:30
477	d2deeec3-1ef1-43aa-8cf6-30e4a20c53fc	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 14:23:50.405868+05:30
489	803e579e-0dac-4102-8eb0-4b3d2b7fdbc6	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 14:35:27.394498+05:30
501	9ef28080-c79f-4761-be3c-c19b1ae03986	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 15:09:20.770384+05:30
513	58df0aed-c9e4-4a6f-a0bc-674c5c3d9eca	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-15 11:18:21.597885+05:30
523	a0ee3839-0a2b-4957-a05e-643f0b08bb48	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-15 11:46:33.329809+05:30
531	643c4834-0032-4ba2-8067-78355d365642	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-15 12:09:39.653779+05:30
539	e28a368d-3875-498d-a451-c1ecc8d2c0cf	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-15 12:26:44.394707+05:30
441	f75d0f14-4535-4297-b34a-470134b4423a	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 12:47:36.141692+05:30
453	f10bb17e-6ae2-40a3-8206-665ee167c881	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 13:42:16.99705+05:30
467	65e1b30e-0076-4de1-a0e7-ad2b7be62c43	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 14:14:16.702758+05:30
479	54cae326-400c-4eb2-81aa-dbb494fe4b14	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 14:24:48.152733+05:30
491	235c9d33-5994-4565-965a-a351cef14a25	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 14:53:55.226197+05:30
503	2da838e8-f94f-4f13-9f08-50de012924a3	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 15:10:53.653013+05:30
515	0ca48c65-b14a-455b-bfe1-cca8ef322d51	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-15 11:18:45.901829+05:30
525	ac667cdf-1f26-4fd4-8047-6f3bcde93fe3	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-15 11:57:03.775921+05:30
533	f688bbcd-8a8b-4a63-a2b0-be621be17159	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-15 12:10:06.361816+05:30
541	facf30a2-11ab-4b7a-8653-2a52f9223a3c	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-15 12:28:16.728205+05:30
443	5463115d-7404-4a10-af39-98373fb2d6f5	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 12:48:06.642717+05:30
455	53d832d7-75d8-48be-8185-91114197ab67	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 13:48:20.666113+05:30
469	bfb78052-dbce-4b26-8f2f-f81ed80bd8ee	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 14:16:41.588288+05:30
481	c2dc86a8-ed08-485a-b170-81ed8db77055	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 14:27:58.55229+05:30
493	2407f00d-11b0-4d27-98c4-c6724b98d54a	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 14:58:03.107714+05:30
505	f19111c3-e4f0-474c-9a26-23b812a9a2b7	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-14 16:45:17.094689+05:30
517	55c5c752-8172-4ecc-8240-a1f7a801d29a	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-15 11:25:55.838811+05:30
527	aa66246d-e322-4e61-a965-a1c9707edef1	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-15 11:59:50.54046+05:30
535	846f0dac-8183-49db-9d6f-a2054e939ed3	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-15 12:17:50.099103+05:30
543	50203e87-6c5d-44bb-8209-c689ba2f9451	inventory_updated	{"old" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":19,"product_inventory_product_id":25,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-15 12:54:42.92798+05:30
588	db57c8ab-4fe8-4f51-8dbb-85e7f06fc60f	inventory_updated	{"old" : {"product_inventory_id":26,"product_inventory_product_id":32,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":26,"product_inventory_product_id":32,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-15 14:38:44.996053+05:30
614	dd05d260-ed53-4c48-8eae-b3c3a383df2a	inventory_updated	{"old" : {"product_inventory_id":29,"product_inventory_product_id":36,"qty":98,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":29,"product_inventory_product_id":36,"qty":98,"manage_stock":true,"stock_availability":true}}	2024-05-16 12:09:37.98987+05:30
635	b98bbe47-cb0c-4bf0-97f6-f5d5ae1449d9	inventory_updated	{"old" : {"product_inventory_id":32,"product_inventory_product_id":41,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":32,"product_inventory_product_id":41,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-17 15:32:53.77374+05:30
606	982bfea8-eb61-4838-be35-529b9a2fc749	inventory_updated	{"old" : {"product_inventory_id":28,"product_inventory_product_id":35,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":28,"product_inventory_product_id":35,"qty":100,"manage_stock":true,"stock_availability":true}}	2024-05-15 14:42:06.181463+05:30
607	59100697-bcce-4d5b-9016-3bb7f03ddd0e	order_created	{"order_id":1,"uuid":"3e2f7328-84c3-4b31-a7f5-70f7977391f0","integration_order_id":null,"sid":"bys16sQrE-Uo6arVag8QYER43Fkmh_f2","order_number":"10001","cart_id":7,"currency":"USD","customer_id":null,"customer_email":"admin@gmail.com","customer_full_name":null,"user_ip":null,"user_agent":null,"coupon":null,"shipping_fee_excl_tax":20.0000,"shipping_fee_incl_tax":20.0000,"discount_amount":0.0000,"sub_total":30.0000,"sub_total_incl_tax":30.0000,"total_qty":1,"total_weight":30.0000,"tax_amount":0.0000,"shipping_note":null,"grand_total":50.0000,"shipping_method":"5a0d1c74-3a6f-4b55-9881-cf57c662487a","shipping_method_name":"Express","shipping_address_id":1,"payment_method":"cod","payment_method_name":"Cash On Delivery","billing_address_id":2,"shipment_status":"processing","payment_status":"pending","created_at":"2024-05-15T09:50:25.586816+00:00","updated_at":"2024-05-15T09:50:25.586816+00:00"}	2024-05-15 15:20:25.586816+05:30
608	e44c3687-6d3e-4bb0-ba71-3656127f1c5f	inventory_updated	{"old" : {"product_inventory_id":29,"product_inventory_product_id":36,"qty":100,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":29,"product_inventory_product_id":36,"qty":99,"manage_stock":true,"stock_availability":true}}	2024-05-15 15:20:25.586816+05:30
609	f0a04bc0-b945-4b86-afdc-9cc100c3fdb6	order_placed	{"order_id":1,"uuid":"3e2f7328-84c3-4b31-a7f5-70f7977391f0","integration_order_id":null,"sid":"bys16sQrE-Uo6arVag8QYER43Fkmh_f2","order_number":"10001","cart_id":7,"currency":"USD","customer_id":null,"customer_email":"admin@gmail.com","customer_full_name":null,"user_ip":null,"user_agent":null,"coupon":null,"shipping_fee_excl_tax":"20.0000","shipping_fee_incl_tax":"20.0000","discount_amount":"0.0000","sub_total":"30.0000","sub_total_incl_tax":"30.0000","total_qty":1,"total_weight":"30.0000","tax_amount":"0.0000","shipping_note":null,"grand_total":"50.0000","shipping_method":"5a0d1c74-3a6f-4b55-9881-cf57c662487a","shipping_method_name":"Express","shipping_address_id":1,"payment_method":"cod","payment_method_name":"Cash On Delivery","billing_address_id":2,"shipment_status":"processing","payment_status":"pending","created_at":"2024-05-15T09:50:25.586Z","updated_at":"2024-05-15T09:50:25.586Z"}	2024-05-15 15:20:25.913361+05:30
610	2e35d34d-b1f9-4894-9079-da8b25d123ab	order_created	{"order_id":2,"uuid":"f461f998-be25-4725-ad47-55731877b07d","integration_order_id":null,"sid":"bys16sQrE-Uo6arVag8QYER43Fkmh_f2","order_number":"10002","cart_id":8,"currency":"USD","customer_id":null,"customer_email":"admin@gmail.com","customer_full_name":null,"user_ip":null,"user_agent":null,"coupon":null,"shipping_fee_excl_tax":20.0000,"shipping_fee_incl_tax":20.0000,"discount_amount":0.0000,"sub_total":30.0000,"sub_total_incl_tax":30.0000,"total_qty":1,"total_weight":30.0000,"tax_amount":0.0000,"shipping_note":null,"grand_total":50.0000,"shipping_method":"5a0d1c74-3a6f-4b55-9881-cf57c662487a","shipping_method_name":"Express","shipping_address_id":3,"payment_method":"cod","payment_method_name":"Cash On Delivery","billing_address_id":4,"shipment_status":"processing","payment_status":"pending","created_at":"2024-05-15T10:46:51.797775+00:00","updated_at":"2024-05-15T10:46:51.797775+00:00"}	2024-05-15 16:16:51.797775+05:30
611	2dff127c-4c4e-4aa2-a852-d84526004881	inventory_updated	{"old" : {"product_inventory_id":29,"product_inventory_product_id":36,"qty":99,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":29,"product_inventory_product_id":36,"qty":98,"manage_stock":true,"stock_availability":true}}	2024-05-15 16:16:51.797775+05:30
612	eb28aea1-c208-4e0e-b2d1-d3aebbc3bb5d	order_placed	{"order_id":2,"uuid":"f461f998-be25-4725-ad47-55731877b07d","integration_order_id":null,"sid":"bys16sQrE-Uo6arVag8QYER43Fkmh_f2","order_number":"10002","cart_id":8,"currency":"USD","customer_id":null,"customer_email":"admin@gmail.com","customer_full_name":null,"user_ip":null,"user_agent":null,"coupon":null,"shipping_fee_excl_tax":"20.0000","shipping_fee_incl_tax":"20.0000","discount_amount":"0.0000","sub_total":"30.0000","sub_total_incl_tax":"30.0000","total_qty":1,"total_weight":"30.0000","tax_amount":"0.0000","shipping_note":null,"grand_total":"50.0000","shipping_method":"5a0d1c74-3a6f-4b55-9881-cf57c662487a","shipping_method_name":"Express","shipping_address_id":3,"payment_method":"cod","payment_method_name":"Cash On Delivery","billing_address_id":4,"shipment_status":"processing","payment_status":"pending","created_at":"2024-05-15T10:46:51.797Z","updated_at":"2024-05-15T10:46:51.797Z"}	2024-05-15 16:16:51.984238+05:30
616	933a3be3-e625-4f37-8699-c9d2127d138f	inventory_updated	{"old" : {"product_inventory_id":29,"product_inventory_product_id":36,"qty":98,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":29,"product_inventory_product_id":36,"qty":98,"manage_stock":true,"stock_availability":true}}	2024-05-16 12:57:18.77034+05:30
618	fa236bc8-296a-42d2-b04c-811b9ebf4e85	inventory_updated	{"old" : {"product_inventory_id":29,"product_inventory_product_id":36,"qty":98,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":29,"product_inventory_product_id":36,"qty":98,"manage_stock":true,"stock_availability":true}}	2024-05-16 14:03:18.152046+05:30
622	dc443683-9d05-473b-9d2f-7e19fa5f90a5	inventory_updated	{"old" : {"product_inventory_id":30,"product_inventory_product_id":37,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":30,"product_inventory_product_id":37,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-16 16:56:25.195745+05:30
625	4691728b-5399-426a-8779-58a847b388f2	inventory_updated	{"old" : {"product_inventory_id":30,"product_inventory_product_id":37,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":30,"product_inventory_product_id":37,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-16 17:00:49.330731+05:30
633	6354e593-4337-4baa-996c-7609052d4c54	inventory_updated	{"old" : {"product_inventory_id":32,"product_inventory_product_id":41,"qty":1,"manage_stock":true,"stock_availability":true}, "new" : {"product_inventory_id":32,"product_inventory_product_id":41,"qty":1,"manage_stock":true,"stock_availability":true}}	2024-05-17 15:32:33.4127+05:30
\.


                                                                                                                                                                                         3998.dat                                                                                            0000600 0004000 0002000 00000001460 14623344605 0014276 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	auth	1.0.1	2024-05-03 16:39:35.859745+05:30	2024-05-03 16:39:35.859745+05:30
3	base	1.0.1	2024-05-03 16:39:36.194505+05:30	2024-05-03 16:39:36.194505+05:30
4	catalog	1.0.6	2024-05-03 16:39:36.326688+05:30	2024-05-03 16:39:36.326688+05:30
11	checkout	1.0.5	2024-05-03 16:39:40.63876+05:30	2024-05-03 16:39:40.63876+05:30
17	cms	1.0.0	2024-05-03 16:39:42.661588+05:30	2024-05-03 16:39:42.661588+05:30
18	customer	1.0.2	2024-05-03 16:39:43.032693+05:30	2024-05-03 16:39:43.032693+05:30
21	oms	1.0.0	2024-05-03 16:39:43.395783+05:30	2024-05-03 16:39:43.395783+05:30
22	promotion	1.0.1	2024-05-03 16:39:43.414853+05:30	2024-05-03 16:39:43.414853+05:30
24	setting	1.0.0	2024-05-03 16:39:44.433351+05:30	2024-05-03 16:39:44.433351+05:30
25	tax	1.0.0	2024-05-03 16:39:44.537994+05:30	2024-05-03 16:39:44.537994+05:30
\.


                                                                                                                                                                                                                4000.dat                                                                                            0000600 0004000 0002000 00000001252 14623344605 0014244 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	3e2f7328-84c3-4b31-a7f5-70f7977391f0	\N	bys16sQrE-Uo6arVag8QYER43Fkmh_f2	10001	7	USD	\N	admin@gmail.com	\N	\N	\N	\N	20.0000	20.0000	0.0000	30.0000	30.0000	1	30.0000	0.0000	\N	50.0000	5a0d1c74-3a6f-4b55-9881-cf57c662487a	Express	1	cod	Cash On Delivery	2	processing	paid	2024-05-15 15:20:25.586816+05:30	2024-05-15 15:20:25.586816+05:30
2	f461f998-be25-4725-ad47-55731877b07d	\N	bys16sQrE-Uo6arVag8QYER43Fkmh_f2	10002	8	USD	\N	admin@gmail.com	\N	\N	\N	\N	20.0000	20.0000	0.0000	30.0000	30.0000	1	30.0000	0.0000	\N	50.0000	5a0d1c74-3a6f-4b55-9881-cf57c662487a	Express	3	cod	Cash On Delivery	4	processing	pending	2024-05-15 16:16:51.797775+05:30	2024-05-15 16:16:51.797775+05:30
\.


                                                                                                                                                                                                                                                                                                                                                      4001.dat                                                                                            0000600 0004000 0002000 00000000602 14623344605 0014243 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	0080deb4-73ed-48e2-a835-062acc8fb6c1	1	Order created	f	2024-05-15 15:20:25.586816+05:30	2024-05-15 15:20:25.586816+05:30
2	26f5b791-5e99-43b2-89a2-fbb69b5abdce	1	Customer paid using cash.	f	2024-05-15 15:59:52.841472+05:30	2024-05-15 15:59:52.841472+05:30
3	bb04cdc4-5c91-499b-95ab-0d10bdcd5cc2	2	Order created	f	2024-05-15 16:16:51.797775+05:30	2024-05-15 16:16:51.797775+05:30
\.


                                                                                                                              4003.dat                                                                                            0000600 0004000 0002000 00000000755 14623344605 0014256 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	2347a8e2-badf-4aef-98ab-3b6a7e19b05b	admin	395009	09191919191	IN	IN-GJ	Surat	varacha	\N
2	934de5fd-90f1-4e27-b505-4c9b9460380b	admin	395009	09191919191	IN	IN-GJ	Surat	varacha	\N
3	49af0032-6ada-4784-8570-d2681b31cf83	admin	395017	09191919191	IN	IN-GJ	Surat	 Magdalla Rd, Police Colony, Gandhi Kutir, Surat, Gujarat 395017, India	\N
4	2626bb7f-866a-428d-b9a2-ab10773096c1	admin	395017	09191919191	IN	IN-GJ	Surat	 Magdalla Rd, Police Colony, Gandhi Kutir, Surat, Gujarat 395017, India	\N
\.


                   4005.dat                                                                                            0000600 0004000 0002000 00000001511 14623344605 0014247 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	525f06f1-bd16-4b26-8c65-5b020afd2ccc	1	36	\N	17	Comfy H Massage Chair	/assets/catalog/4795/7235/products-eight-thumb.png	30.0000	30.0000	30.0000	1	30.0000	30.0000	0.0000	0.0000	0.0000	30.0000	30.0000	5	[{"attribute_code":"color","attribute_name":"Color","attribute_id":1,"option_id":3,"option_text":"Yellow"},{"attribute_code":"size","attribute_name":"Size","attribute_id":2,"option_id":5,"option_text":"XL"}]	\N	\N
2	73db9382-cc8c-4e96-b393-ad26020c1354	2	36	\N	17	Comfy H Massage Chair	/assets/catalog/4795/7235/products-eight-thumb.png	30.0000	30.0000	30.0000	1	30.0000	30.0000	0.0000	0.0000	0.0000	30.0000	30.0000	5	[{"attribute_code":"color","attribute_name":"Color","attribute_id":1,"option_id":3,"option_text":"Yellow"},{"attribute_code":"size","attribute_name":"Size","attribute_id":2,"option_id":5,"option_text":"XL"}]	\N	\N
\.


                                                                                                                                                                                       4008.dat                                                                                            0000600 0004000 0002000 00000000160 14623344605 0014251 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	96774c31-8af8-4b3b-a242-b699fa459e31	1	\N	offline	50.0000	\N	capture	\N	2024-05-15 15:59:52.824874+05:30
\.


                                                                                                                                                                                                                                                                                                                                                                                                                4010.dat                                                                                            0000600 0004000 0002000 00000005073 14623344605 0014252 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        34	f960a65a-70df-499b-a6b3-2956598451f0	simple	4	t	1	11	15.0000	15.0000	\N	t	2024-05-15 14:38:29.773179+05:30	2024-05-15 14:38:29.773179+05:30	25	Google	Material	Massage Chair	1200	Leather, Plastic	3	Strong , Washable	Relieve Stress	Muscle Therapy;Blood Flow Control	20	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. 	https://www.youtube.com/watch?v=XEzRZ35urlk
32	54d7ca5a-6741-437b-8fef-03c36bef0182	simple	4	t	1	10	15.0000	15.0000	\N	t	2024-05-15 14:36:04.304261+05:30	2024-05-15 14:36:04.304261+05:30	25	Google	Material	Massage Chair	1200	Leather, Plastic	black	Strong , Washable	Relieve Stress	Muscle Therapy;Blood Flow Control	20	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. 	https://www.youtube.com/watch?v=XEzRZ35urlk
35	a0ae3b8c-5080-40a6-8b24-d7440e435010	simple	5	t	1	12	30.0000	30.0000	\N	t	2024-05-15 14:40:27.352194+05:30	2024-05-15 14:40:27.352194+05:30	24	Google	Material	Foot	35	Leather, Plastic	Black	Strong , Washable	Relieve Stress	Muscle Therapy;Blood Flow Control	25	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. 	https://www.youtube.com/watch?v=XEzRZ35urlk
37	0caf48d0-3be3-47bd-96b6-f267efcdabbe	simple	\N	t	1	0	0.0000	0.0000	\N	t	2024-05-16 16:43:30.671512+05:30	2024-05-16 16:43:30.671512+05:30	\N	Amazon	Material	Foot	1200	Leather, Plastic	Black	Strong , Washable	Relieve Stress	Muscle Therapy;Blood Flow Control	20	test	https://www.youtube.com/watch?v=XEzRZ35urlk
36	c0bd4906-67b8-4d00-b126-7db606156444	simple	5	t	1	17	30.0000	30.0000	\N	t	2024-05-15 14:41:54.250659+05:30	2024-05-15 14:41:54.250659+05:30	24	Google	Material	Foot Massage	1280	Leather, Plastic	Black	Strong , Washable	Relieve Stress	Muscle Therapy;Blood Flow Control	20	Determine your Life Wellness with Advanced Whole body massage technology with auto wellness program.	https://www.youtube.com/watch?v=XEzRZ35urlk
41	8620842e-5d37-4995-a4ad-422852ff7333	simple	\N	t	1	1	0.0000	0.0000	\N	t	2024-05-17 15:31:37.533499+05:30	2024-05-17 15:31:37.533499+05:30	\N	none	none	none	none	none	none	none	none	none	none	test	none
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                     4011.dat                                                                                            0000600 0004000 0002000 00000000205 14623344605 0014243 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        261	34	1	3	Yellow
262	34	2	5	XL
263	32	1	1	White
264	32	2	4	XXL
269	35	1	2	Black
270	35	2	4	XXL
275	36	1	3	Yellow
276	36	2	5	XL
\.


                                                                                                                                                                                                                                                                                                                                                                                           4013.dat                                                                                            0000600 0004000 0002000 00000000052 14623344605 0014245 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        6	3	36
7	3	35
8	3	34
11	6	37
15	6	35
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      4015.dat                                                                                            0000600 0004000 0002000 00000000005 14623344605 0014245 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           4017.dat                                                                                            0000600 0004000 0002000 00000000005 14623344605 0014247 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           4019.dat                                                                                            0000600 0004000 0002000 00000003241 14623344605 0014256 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        28	34	Gold Glory Massage Chair	<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.&nbsp;</p>	\N	gold-glory-massage-chair-11	Gold Glory Massage Chair	Gold Glory Massage Chair	Gold Glory Massage Chair
27	32	Gold Glory Massage Chair	<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.&nbsp;</p>	\N	gold-glory-massage-chair	Gold Glory Massage Chair	Gold Glory Massage Chair	Gold Glory Massage Chair
29	35	Comfy H Massage Chair	<p><strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.&nbsp;</p>	\N	comfy-massage-chair	Comfy H Massage Chair	Comfy H Massage Chair	Comfy H Massage Chair
30	36	Foot Massage	<p><strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.&nbsp;</p>	\N	foot-massage	foot massage	foot massage	foot massage
31	37	Home Slider		\N	Home-Slider	Home Slider	Home Slider	Home Slider
33	41	Home Slider One		\N	home-slider-one	Home Slider One	Home Slider One	Home Slider One
\.


                                                                                                                                                                                                                                                                                                                                                               4021.dat                                                                                            0000600 0004000 0002000 00000012223 14623344605 0014247 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        128	37	/assets/catalog/2448/6679/home-slider.png	/assets/catalog/2448/6679/home-slider-thumb.png	/assets/catalog/2448/6679/home-slider-listing.png	/assets/catalog/2448/6679/home-slider-single.png	t
120	36	/assets/catalog/4795/7235/products-eight.png	/assets/catalog/4795/7235/products-eight-thumb.png	/assets/catalog/4795/7235/products-eight-listing.png	/assets/catalog/4795/7235/products-eight-single.png	t
109	34	/assets/catalog/4335/2497/thumbnail-five.png	/assets/catalog/4335/2497/thumbnail-five-thumb.png	/assets/catalog/4335/2497/thumbnail-five-listing.png	/assets/catalog/4335/2497/thumbnail-five-single.png	f
112	34	/assets/catalog/4335/2497/thumbnail-three.png	/assets/catalog/4335/2497/thumbnail-three-thumb.png	/assets/catalog/4335/2497/thumbnail-three-listing.png	/assets/catalog/4335/2497/thumbnail-three-single.png	f
110	34	/assets/catalog/4335/2497/thumbnail-four.png	/assets/catalog/4335/2497/thumbnail-four-thumb.png	/assets/catalog/4335/2497/thumbnail-four-listing.png	/assets/catalog/4335/2497/thumbnail-four-single.png	f
113	34	/assets/catalog/4335/2497/thumbnail-two.png	/assets/catalog/4335/2497/thumbnail-two-thumb.png	/assets/catalog/4335/2497/thumbnail-two-listing.png	/assets/catalog/4335/2497/thumbnail-two-single.png	f
108	34	/assets/catalog/4335/2497/products-one.png	/assets/catalog/4335/2497/products-one-thumb.png	/assets/catalog/4335/2497/products-one-listing.png	/assets/catalog/4335/2497/products-one-single.png	t
111	34	/assets/catalog/4335/2497/thumbnail-one.png	/assets/catalog/4335/2497/thumbnail-one-thumb.png	/assets/catalog/4335/2497/thumbnail-one-listing.png	/assets/catalog/4335/2497/thumbnail-one-single.png	f
102	32	/assets/catalog/6218/7864/products-one.png	/assets/catalog/6218/7864/products-one-thumb.png	/assets/catalog/6218/7864/products-one-listing.png	/assets/catalog/6218/7864/products-one-single.png	t
103	32	/assets/catalog/6218/7864/thumbnail-five.png	/assets/catalog/6218/7864/thumbnail-five-thumb.png	/assets/catalog/6218/7864/thumbnail-five-listing.png	/assets/catalog/6218/7864/thumbnail-five-single.png	f
104	32	/assets/catalog/6218/7864/thumbnail-four.png	/assets/catalog/6218/7864/thumbnail-four-thumb.png	/assets/catalog/6218/7864/thumbnail-four-listing.png	/assets/catalog/6218/7864/thumbnail-four-single.png	f
105	32	/assets/catalog/6218/7864/thumbnail-one.png	/assets/catalog/6218/7864/thumbnail-one-thumb.png	/assets/catalog/6218/7864/thumbnail-one-listing.png	/assets/catalog/6218/7864/thumbnail-one-single.png	f
106	32	/assets/catalog/6218/7864/thumbnail-three.png	/assets/catalog/6218/7864/thumbnail-three-thumb.png	/assets/catalog/6218/7864/thumbnail-three-listing.png	/assets/catalog/6218/7864/thumbnail-three-single.png	f
107	32	/assets/catalog/6218/7864/thumbnail-two.png	/assets/catalog/6218/7864/thumbnail-two-thumb.png	/assets/catalog/6218/7864/thumbnail-two-listing.png	/assets/catalog/6218/7864/thumbnail-two-single.png	f
123	36	/assets/catalog/4795/7235/thumbnail-one.png	/assets/catalog/4795/7235/thumbnail-one-thumb.png	/assets/catalog/4795/7235/thumbnail-one-listing.png	/assets/catalog/4795/7235/thumbnail-one-single.png	f
121	36	/assets/catalog/4795/7235/thumbnail-five.png	/assets/catalog/4795/7235/thumbnail-five-thumb.png	/assets/catalog/4795/7235/thumbnail-five-listing.png	/assets/catalog/4795/7235/thumbnail-five-single.png	f
124	36	/assets/catalog/4795/7235/thumbnail-three.png	/assets/catalog/4795/7235/thumbnail-three-thumb.png	/assets/catalog/4795/7235/thumbnail-three-listing.png	/assets/catalog/4795/7235/thumbnail-three-single.png	f
122	36	/assets/catalog/4795/7235/thumbnail-four.png	/assets/catalog/4795/7235/thumbnail-four-thumb.png	/assets/catalog/4795/7235/thumbnail-four-listing.png	/assets/catalog/4795/7235/thumbnail-four-single.png	f
125	36	/assets/catalog/4795/7235/thumbnail-two.png	/assets/catalog/4795/7235/thumbnail-two-thumb.png	/assets/catalog/4795/7235/thumbnail-two-listing.png	/assets/catalog/4795/7235/thumbnail-two-single.png	f
114	35	/assets/catalog/1360/8670/products-two.png	/assets/catalog/1360/8670/products-two-thumb.png	/assets/catalog/1360/8670/products-two-listing.png	/assets/catalog/1360/8670/products-two-single.png	t
115	35	/assets/catalog/1360/8670/thumbnail-five.png	/assets/catalog/1360/8670/thumbnail-five-thumb.png	/assets/catalog/1360/8670/thumbnail-five-listing.png	/assets/catalog/1360/8670/thumbnail-five-single.png	f
116	35	/assets/catalog/1360/8670/thumbnail-four.png	/assets/catalog/1360/8670/thumbnail-four-thumb.png	/assets/catalog/1360/8670/thumbnail-four-listing.png	/assets/catalog/1360/8670/thumbnail-four-single.png	f
117	35	/assets/catalog/1360/8670/thumbnail-one.png	/assets/catalog/1360/8670/thumbnail-one-thumb.png	/assets/catalog/1360/8670/thumbnail-one-listing.png	/assets/catalog/1360/8670/thumbnail-one-single.png	f
118	35	/assets/catalog/1360/8670/thumbnail-three.png	/assets/catalog/1360/8670/thumbnail-three-thumb.png	/assets/catalog/1360/8670/thumbnail-three-listing.png	/assets/catalog/1360/8670/thumbnail-three-single.png	f
119	35	/assets/catalog/1360/8670/thumbnail-two.png	/assets/catalog/1360/8670/thumbnail-two-thumb.png	/assets/catalog/1360/8670/thumbnail-two-listing.png	/assets/catalog/1360/8670/thumbnail-two-single.png	f
130	41	/assets/catalog/1898/4472/home-slider-one.png	\N	\N	\N	t
\.


                                                                                                                                                                                                                                                                                                                                                                             4023.dat                                                                                            0000600 0004000 0002000 00000000124 14623344605 0014246 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        27	34	100	t	t
26	32	100	t	t
28	35	100	t	t
29	36	98	t	t
30	37	1	t	t
32	41	1	t	t
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                            4026.dat                                                                                            0000600 0004000 0002000 00000000005 14623344605 0014247 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           4028.dat                                                                                            0000600 0004000 0002000 00000000475 14623344605 0014264 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        NugRFb2jszYfuRBpfikrWZ7w3PAAk6kD	{"cookie":{"originalMaxAge":86400000,"expires":"2024-05-23T09:47:07.915Z","httpOnly":true,"path":"/"}}	2024-05-23 09:59:22
DXgbi_VvYK97hQl-axUU0vBB0dLXux21	{"cookie":{"originalMaxAge":86400000,"expires":"2024-05-22T11:13:42.238Z","httpOnly":true,"path":"/"}}	2024-05-23 10:12:35
\.


                                                                                                                                                                                                   4029.dat                                                                                            0000600 0004000 0002000 00000001433 14623344605 0014260 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	45bcc645-0918-4e30-ba05-009385b90304	stripePaymentStatus	1	f
2	58c32fe1-f658-487f-8084-143e9ced1725	stripeDislayName	Credit Card	f
3	e7cd845f-e49d-484b-9c12-8f289985632b	stripePublishableKey		f
4	8ad75b60-15bf-4756-a273-8e8962c34ce2	stripeSecretKey		f
5	3d56b010-0bdc-4a61-bdcb-96f026527675	stripeEndpointSecret		f
6	6ba77a62-2508-4af8-ae87-7e6b109a6faf	paypalPaymentStatus	1	f
7	6c3615cc-ea9f-464d-b509-9f258b3c0ec8	paypalDislayName	Paypal	f
8	499f6b88-fbc9-454a-ae71-1042fe44a720	paypalClientId		f
9	35f2ec00-76cb-4b35-9a5a-456338609f12	paypalClientSecret		f
10	54947cdc-87ad-4c21-a52c-6ebc5610290f	paypalEnvironment	https://api-m.sandbox.paypal.com	f
11	0272f425-620a-4524-b344-dc123e3fbdd7	codPaymentStatus	1	f
12	0574cc4a-1b7b-4233-bc43-701160f21ec2	codDislayName	Cash On Delivery	f
\.


                                                                                                                                                                                                                                     4031.dat                                                                                            0000600 0004000 0002000 00000000005 14623344605 0014243 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           4033.dat                                                                                            0000600 0004000 0002000 00000000064 14623344605 0014252 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	5a0d1c74-3a6f-4b55-9881-cf57c662487a	Express
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                            4035.dat                                                                                            0000600 0004000 0002000 00000000155 14623344605 0014255 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	c6dc5207-db73-4e66-98b4-385054acefc5	Ever Shop	IN
2	c075c6dd-da57-4144-80da-3d8cd10922f4	Ever Shop	US
\.


                                                                                                                                                                                                                                                                                                                                                                                                                   4036.dat                                                                                            0000600 0004000 0002000 00000000143 14623344605 0014253 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	1	2	t	20.0000	\N	price	100.0000	5.0000	\N	\N
2	1	1	t	20.0000	\N	price	100.0000	5.0000	\N	\N
\.


                                                                                                                                                                                                                                                                                                                                                                                                                             4038.dat                                                                                            0000600 0004000 0002000 00000000005 14623344605 0014252 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           4041.dat                                                                                            0000600 0004000 0002000 00000000072 14623344605 0014250 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	50121b7a-864c-44c2-8117-0b4e8f8081d6	Taxable Goods
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                      4043.dat                                                                                            0000600 0004000 0002000 00000000103 14623344605 0014245 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	0fc3bc63-4578-4876-b2db-30bf694fb587	Tax	1	*	*	*	0.0000	f	0
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                             4045.dat                                                                                            0000600 0004000 0002000 00000011733 14623344605 0014262 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        320	en	/massage-chair/exitiiika-massage-chair-two	/product/5bedece9-0fb4-4df5-8125-6ec01c5f1f72	5bedece9-0fb4-4df5-8125-6ec01c5f1f72	product
367	en	/thermal-heating-bed	/category/84de9de7-2f96-4208-b839-a2cd13ae4e18	84de9de7-2f96-4208-b839-a2cd13ae4e18	category
359	en	/foot-leg-massager	/category/c0d95aea-166c-4b18-91b2-de23193c1b95	c0d95aea-166c-4b18-91b2-de23193c1b95	category
351	en	/gym-products	/category/9a673b3b-c251-4d8e-ac29-63c8c324dade	9a673b3b-c251-4d8e-ac29-63c8c324dade	category
347	en	/new-arrivals	/category/d2d26cdc-9153-4c2b-99d9-045939906fb1	d2d26cdc-9153-4c2b-99d9-045939906fb1	category
330	en	/corporate-gifts	/category/4eef8f7e-253c-4616-afec-4ec6a070aa35	4eef8f7e-253c-4616-afec-4ec6a070aa35	category
310	en	/full-body-massage-chair	/product/3433beba-2dbc-4867-a354-e1c97c12b652	3433beba-2dbc-4867-a354-e1c97c12b652	product
312	en	/relaxo-massage-chair-one	/product/f4584e77-8e38-441f-8c6d-ea4405d24bd0	f4584e77-8e38-441f-8c6d-ea4405d24bd0	product
315	en	/full-body-massage-chair-150	/product/f0b7d863-8995-4856-a7fa-ce5379de221b	f0b7d863-8995-4856-a7fa-ce5379de221b	product
319	en	/comfy-h-massage-chair	/product/29ac2f88-9557-4e81-9be6-d9a2d84cc954	29ac2f88-9557-4e81-9be6-d9a2d84cc954	product
325	en	/full-body-massage-chair-five	/product/16914e7d-0dfa-4a08-9c10-777bb3112222	16914e7d-0dfa-4a08-9c10-777bb3112222	product
328	en	/full-body-massage-chair-three	/product/fe59adc2-ed38-46ed-b5b4-49f5e70b9943	fe59adc2-ed38-46ed-b5b4-49f5e70b9943	product
317	en	/exitiiika-massage-chair-three	/product/f8a1dc66-4bf3-4acf-8473-61a7fc6a5a0a	f8a1dc66-4bf3-4acf-8473-61a7fc6a5a0a	product
2	en	/floral-maxi-dress	/product/f6f5394b-1e1d-4d4d-87f5-c701a5856e07	f6f5394b-1e1d-4d4d-87f5-c701a5856e07	product
4	en	/classic-leather-loafers	/product/a1079f21-7d2d-4efb-b221-0c40a365ae2b	a1079f21-7d2d-4efb-b221-0c40a365ae2b	product
6	en	/denim-skinny-jeans	/product/a8543273-9c0f-447c-ae05-185cb4295940	a8543273-9c0f-447c-ae05-185cb4295940	product
518	en	/Home-Slider	/product/0caf48d0-3be3-47bd-96b6-f267efcdabbe	0caf48d0-3be3-47bd-96b6-f267efcdabbe	product
522	en	/home-slider-one	/product/8620842e-5d37-4995-a4ad-422852ff7333	8620842e-5d37-4995-a4ad-422852ff7333	product
326	en	/foot-leg-massager/relaxo-massage-chair-four	/product/ca58d0d7-9e20-4363-a558-e90acce5718c	ca58d0d7-9e20-4363-a558-e90acce5718c	product
492	en	/massage-chair/gold-glory-massage-chair	/product/54d7ca5a-6741-437b-8fef-03c36bef0182	54d7ca5a-6741-437b-8fef-03c36bef0182	product
502	en	/thermal-heating-bed/comfy-massage-chair	/product/a0ae3b8c-5080-40a6-8b24-d7440e435010	a0ae3b8c-5080-40a6-8b24-d7440e435010	product
371	en	/massage-chair	/category/b6b17ee3-980c-4ed0-bf1a-7da8b8fd26d9	b6b17ee3-980c-4ed0-bf1a-7da8b8fd26d9	category
322	en	/salon-spa-jacuzzi/relaxo-massage-chair-three	/product/a797fccb-7caf-4bbc-a4f2-6f06aea88f74	a797fccb-7caf-4bbc-a4f2-6f06aea88f74	product
313	en	/thermal-heating-bed/gold-glory-massage-three	/product/541da7f7-439e-4b72-90f5-faf9a998a415	541da7f7-439e-4b72-90f5-faf9a998a415	product
363	en	/thermal-heating-hat	/category/71dcc6a9-defd-4b86-bcef-10dffeadd4a8	71dcc6a9-defd-4b86-bcef-10dffeadd4a8	category
318	en	/thermal-heating-hat/gold-glory-massage-two	/product/1cc5aa42-211c-4ff8-abfd-4b26e3872cb8	1cc5aa42-211c-4ff8-abfd-4b26e3872cb8	product
355	en	/salon-spa-jacuzzi	/category/1166da0a-eb0c-4b4f-8d9c-0d452276eab9	1166da0a-eb0c-4b4f-8d9c-0d452276eab9	category
329	en	/gym-products/relaxo-massage-chair-two	/product/8d5446d1-dd70-4746-a22e-5b052fe3945f	8d5446d1-dd70-4746-a22e-5b052fe3945f	product
324	en	/gold-glory-massage-chair	/product/304f363c-1080-4d3b-a6b2-2556d0e774ed	304f363c-1080-4d3b-a6b2-2556d0e774ed	product
327	en	/corporate-gifts/exitiiika-massage-chair-four	/product/0d87d503-1909-43a0-89d6-15a44ac9ae67	0d87d503-1909-43a0-89d6-15a44ac9ae67	product
7	en	/striped-cotton-sweater	/product/da1afcdb-8a49-4070-82b5-48c9a688e08e	da1afcdb-8a49-4070-82b5-48c9a688e08e	product
309	en	/robotics-zero-capsule-massage-chair	/product/bf270d58-b1ad-43ff-b7c7-82bca5a8cbb1	bf270d58-b1ad-43ff-b7c7-82bca5a8cbb1	product
311	en	/gold-glory-massage-four	/product/9862f749-3d63-475e-a306-f6a15319beb8	9862f749-3d63-475e-a306-f6a15319beb8	product
314	en	/full_body_massage_chair_two	/product/312872b1-87d4-4cc6-8867-7c8daf6f9380	312872b1-87d4-4cc6-8867-7c8daf6f9380	product
316	en	/gold-glory-massage-one	/product/b069db60-1b1a-433a-9e70-e1a44e7a720f	b069db60-1b1a-433a-9e70-e1a44e7a720f	product
321	en	/exitiiika-massage-chair-one	/product/f503cdf6-ef81-4a33-876d-587dba6ff66d	f503cdf6-ef81-4a33-876d-587dba6ff66d	product
323	en	/new-arrivals/full-body-massage-chair-four	/product/b7acf07a-5223-4481-b555-ec6dca39a36d	b7acf07a-5223-4481-b555-ec6dca39a36d	product
494	en	/massage-chair/gold-glory-massage-chair-11	/product/f960a65a-70df-499b-a6b3-2956598451f0	f960a65a-70df-499b-a6b3-2956598451f0	product
504	en	/thermal-heating-bed/foot-massage	/product/c0bd4906-67b8-4d00-b126-7db606156444	c0bd4906-67b8-4d00-b126-7db606156444	product
521	en	/home_slider_one	/product/21de8214-5461-4ccf-be33-95a30d65cb7a	21de8214-5461-4ccf-be33-95a30d65cb7a	product
\.


                                     4047.dat                                                                                            0000600 0004000 0002000 00000000435 14623344605 0014261 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	37143e87-1078-4138-b457-d1ed97871cce	1	1	2	\N	\N	\N	f
3	b5d510ff-0b65-43c1-9e95-5bc5839964c9	1	1	2	\N	\N	\N	f
2	4260776f-c2bf-4baa-bcb0-1ee057661554	1	1	2	\N	\N	\N	t
4	7a73c815-09b8-4e69-904a-30f33b05608b	1	1	2	\N	\N	\N	t
5	4f57e3a5-aa1d-430a-8697-a28f9a00e256	1	1	2	\N	\N	\N	t
\.


                                                                                                                                                                                                                                   restore.sql                                                                                         0000600 0004000 0002000 00000373140 14623344605 0015403 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 14.12
-- Dumped by pg_dump version 16.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE evershop;
--
-- Name: evershop; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE evershop WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_India.1252';


ALTER DATABASE evershop OWNER TO postgres;

\connect evershop

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: add_category_created_event(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_category_created_event() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      INSERT INTO event (name, data)
      VALUES ('category_created', row_to_json(NEW));
      RETURN NEW;
    END;
    $$;


ALTER FUNCTION public.add_category_created_event() OWNER TO postgres;

--
-- Name: add_category_deleted_event(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_category_deleted_event() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      INSERT INTO event (name, data)
      VALUES ('category_deleted', row_to_json(OLD));
      RETURN OLD;
    END;
    $$;


ALTER FUNCTION public.add_category_deleted_event() OWNER TO postgres;

--
-- Name: add_category_updated_event(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_category_updated_event() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      INSERT INTO event (name, data)
      VALUES ('category_updated', row_to_json(NEW));
      RETURN NEW;
    END;
    $$;


ALTER FUNCTION public.add_category_updated_event() OWNER TO postgres;

--
-- Name: add_customer_created_event(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_customer_created_event() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      INSERT INTO event (name, data)
      VALUES ('customer_created', row_to_json(NEW));
      RETURN NEW;
    END;
    $$;


ALTER FUNCTION public.add_customer_created_event() OWNER TO postgres;

--
-- Name: add_customer_deleted_event(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_customer_deleted_event() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      INSERT INTO event (name, data)
      VALUES ('customer_deleted', row_to_json(OLD));
      RETURN OLD;
    END;
    $$;


ALTER FUNCTION public.add_customer_deleted_event() OWNER TO postgres;

--
-- Name: add_customer_updated_event(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_customer_updated_event() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      INSERT INTO event (name, data)
      VALUES ('customer_updated', row_to_json(NEW));
      RETURN NEW;
    END;
    $$;


ALTER FUNCTION public.add_customer_updated_event() OWNER TO postgres;

--
-- Name: add_order_created_event(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_order_created_event() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      INSERT INTO event (name, data)
      VALUES ('order_created', row_to_json(NEW));
      RETURN NEW;
    END;
    $$;


ALTER FUNCTION public.add_order_created_event() OWNER TO postgres;

--
-- Name: add_product_created_event(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_product_created_event() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      INSERT INTO event (name, data)
      VALUES ('product_created', row_to_json(NEW));
      RETURN NEW;
    END;
    $$;


ALTER FUNCTION public.add_product_created_event() OWNER TO postgres;

--
-- Name: add_product_deleted_event(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_product_deleted_event() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      INSERT INTO event (name, data)
      VALUES ('product_deleted', row_to_json(OLD));
      RETURN OLD;
    END;
    $$;


ALTER FUNCTION public.add_product_deleted_event() OWNER TO postgres;

--
-- Name: add_product_inventory_updated_event(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_product_inventory_updated_event() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      INSERT INTO event (name, data)
      VALUES ('inventory_updated', json_build_object('old', row_to_json(OLD), 'new', row_to_json(NEW)));
      RETURN NEW;
    END;
    $$;


ALTER FUNCTION public.add_product_inventory_updated_event() OWNER TO postgres;

--
-- Name: add_product_updated_event(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_product_updated_event() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      INSERT INTO event (name, data)
      VALUES ('product_updated', row_to_json(NEW));
      RETURN NEW;
    END;
    $$;


ALTER FUNCTION public.add_product_updated_event() OWNER TO postgres;

--
-- Name: build_url_key(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.build_url_key() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
      url_key TEXT;
    BEGIN
      IF(NEW.url_key IS NULL) THEN
        url_key = regexp_replace(NEW.name, '[^a-zA-Z0-9]+', '-', 'g');
        url_key = regexp_replace(url_key, '^-|-$', '', 'g');
        url_key = lower(url_key);
        url_key = url_key || '-' || (SELECT floor(random() * 1000000)::text);
        NEW.url_key = url_key;
      ELSE
        IF (NEW.url_key ~ '[/\#]') THEN
          RAISE EXCEPTION 'Invalid url_key: %', NEW.url_key;
        END IF;
      END IF;
      RETURN NEW;
    END;
    $_$;


ALTER FUNCTION public.build_url_key() OWNER TO postgres;

--
-- Name: delete_product_attribute_value_index(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.delete_product_attribute_value_index() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        DELETE FROM "product_attribute_value_index" WHERE "product_attribute_value_index".option_id = OLD.attribute_option_id AND "product_attribute_value_index"."attribute_id" = OLD.attribute_id;
        RETURN OLD;
      END;
      $$;


ALTER FUNCTION public.delete_product_attribute_value_index() OWNER TO postgres;

--
-- Name: delete_sub_categories(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.delete_sub_categories() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      sub_categories RECORD;
    BEGIN
      FOR sub_categories IN
        WITH RECURSIVE sub_categories AS (
          SELECT * FROM category WHERE parent_id = OLD.category_id
          UNION
          SELECT c.* FROM category c
          INNER JOIN sub_categories sc ON c.parent_id = sc.category_id
        ) SELECT * FROM sub_categories
      LOOP
        DELETE FROM category WHERE category_id = sub_categories.category_id;
      END LOOP;
      RETURN OLD;
    END;
    $$;


ALTER FUNCTION public.delete_sub_categories() OWNER TO postgres;

--
-- Name: delete_variant_group_after_attribute_type_changed(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.delete_variant_group_after_attribute_type_changed() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        IF (OLD.type = 'select' AND NEW.type <> 'select') THEN
          DELETE FROM "variant_group" WHERE ("variant_group".attribute_one = OLD.attribute_id OR "variant_group".attribute_two = OLD.attribute_id OR "variant_group".attribute_three = OLD.attribute_id OR "variant_group".attribute_four = OLD.attribute_id OR "variant_group".attribute_five = OLD.attribute_id);
        END IF;
        RETURN NEW;
      END
      $$;


ALTER FUNCTION public.delete_variant_group_after_attribute_type_changed() OWNER TO postgres;

--
-- Name: prevent_change_attribute_group(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.prevent_change_attribute_group() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        IF OLD.group_id != NEW.group_id AND OLD.variant_group_id IS NOT NULL THEN
          RAISE EXCEPTION 'Cannot change attribute group of product with variants';
        END IF;
        RETURN NEW;
      END;
      $$;


ALTER FUNCTION public.prevent_change_attribute_group() OWNER TO postgres;

--
-- Name: prevent_delete_default_attribute_group(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.prevent_delete_default_attribute_group() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        IF OLD.attribute_group_id = 1 THEN
          RAISE EXCEPTION 'Cannot delete default attribute group';
        END IF;
        RETURN OLD;
      END;
      $$;


ALTER FUNCTION public.prevent_delete_default_attribute_group() OWNER TO postgres;

--
-- Name: prevent_delete_default_customer_group(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.prevent_delete_default_customer_group() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        IF OLD.customer_group_id = 1 THEN
          RAISE EXCEPTION 'Cannot delete default customer group';
        END IF;
        RETURN OLD;
      END;
      $$;


ALTER FUNCTION public.prevent_delete_default_customer_group() OWNER TO postgres;

--
-- Name: prevent_delete_default_tax_class(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.prevent_delete_default_tax_class() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        IF OLD.tax_class_id = 1 THEN
          RAISE EXCEPTION 'Cannot delete default tax class';
        END IF;
        RETURN OLD;
      END;
      $$;


ALTER FUNCTION public.prevent_delete_default_tax_class() OWNER TO postgres;

--
-- Name: product_image_insert_trigger(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.product_image_insert_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        INSERT INTO event (name, data)
        VALUES ('product_image_added', row_to_json(NEW));
        RETURN NEW;
      END;
      $$;


ALTER FUNCTION public.product_image_insert_trigger() OWNER TO postgres;

--
-- Name: reduce_product_stock_when_order_placed(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.reduce_product_stock_when_order_placed() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        UPDATE product_inventory SET qty = qty - NEW.qty WHERE product_inventory_product_id = NEW.product_id AND manage_stock = TRUE;
        RETURN NEW;
      END
      $$;


ALTER FUNCTION public.reduce_product_stock_when_order_placed() OWNER TO postgres;

--
-- Name: remove_attribute_from_group(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.remove_attribute_from_group() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        DELETE FROM product_attribute_value_index WHERE product_attribute_value_index.attribute_id = OLD.attribute_id AND product_attribute_value_index.product_id IN (SELECT product.product_id FROM product WHERE product.group_id = OLD.group_id);
        DELETE FROM variant_group WHERE variant_group.attribute_group_id = OLD.group_id AND (variant_group.attribute_one = OLD.attribute_id OR variant_group.attribute_two = OLD.attribute_id OR variant_group.attribute_three = OLD.attribute_id OR variant_group.attribute_four = OLD.attribute_id OR variant_group.attribute_five = OLD.attribute_id);
        RETURN OLD;
      END;
      $$;


ALTER FUNCTION public.remove_attribute_from_group() OWNER TO postgres;

--
-- Name: set_coupon_used_time(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.set_coupon_used_time() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        UPDATE "coupon" SET used_time = used_time + 1 WHERE coupon = NEW.coupon;
        RETURN NEW;
      END;
      $$;


ALTER FUNCTION public.set_coupon_used_time() OWNER TO postgres;

--
-- Name: set_default_customer_group(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.set_default_customer_group() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        IF NEW.group_id IS NULL THEN
          NEW.group_id = 1;
        END IF;
        RETURN NEW;
      END;
      $$;


ALTER FUNCTION public.set_default_customer_group() OWNER TO postgres;

--
-- Name: update_attribute_index_and_variant_group_visibility(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_attribute_index_and_variant_group_visibility() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        DELETE FROM "product_attribute_value_index"
        WHERE "product_attribute_value_index"."product_id" = NEW.product_id 
        AND "product_attribute_value_index"."attribute_id" NOT IN (SELECT "attribute_group_link"."attribute_id" FROM "attribute_group_link" WHERE "attribute_group_link"."group_id" = NEW.group_id);
        UPDATE "variant_group" SET visibility = COALESCE((SELECT bool_or(visibility) FROM "product" WHERE "product"."variant_group_id" = NEW.variant_group_id AND "product"."status" = TRUE GROUP BY "product"."variant_group_id"), FALSE) WHERE "variant_group"."variant_group_id" = NEW.variant_group_id;
        RETURN NEW;
      END;
      $$;


ALTER FUNCTION public.update_attribute_index_and_variant_group_visibility() OWNER TO postgres;

--
-- Name: update_product_attribute_option_value_text(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_product_attribute_option_value_text() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        UPDATE "product_attribute_value_index" SET "option_text" = NEW.option_text
        WHERE "product_attribute_value_index".option_id = NEW.attribute_option_id AND "product_attribute_value_index".attribute_id = NEW.attribute_id;
        RETURN NEW;
      END;
      $$;


ALTER FUNCTION public.update_product_attribute_option_value_text() OWNER TO postgres;

--
-- Name: update_variant_group_visibility(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_variant_group_visibility() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        UPDATE "variant_group" SET visibility = (SELECT bool_or(visibility) FROM "product" WHERE "product"."variant_group_id" = NEW.variant_group_id AND "product"."status" = TRUE) WHERE "variant_group"."variant_group_id" = NEW.variant_group_id;
        RETURN NEW;
      END;
      $$;


ALTER FUNCTION public.update_variant_group_visibility() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_user (
    admin_user_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    status boolean DEFAULT true NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    full_name character varying,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.admin_user OWNER TO postgres;

--
-- Name: admin_user_admin_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.admin_user ALTER COLUMN admin_user_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.admin_user_admin_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attribute (
    attribute_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    attribute_code character varying NOT NULL,
    attribute_name character varying NOT NULL,
    type character varying NOT NULL,
    is_required boolean DEFAULT false NOT NULL,
    display_on_frontend boolean DEFAULT false NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    is_filterable boolean DEFAULT false NOT NULL
);


ALTER TABLE public.attribute OWNER TO postgres;

--
-- Name: attribute_attribute_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.attribute ALTER COLUMN attribute_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.attribute_attribute_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: attribute_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attribute_group (
    attribute_group_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    group_name text NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.attribute_group OWNER TO postgres;

--
-- Name: attribute_group_attribute_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.attribute_group ALTER COLUMN attribute_group_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.attribute_group_attribute_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: attribute_group_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attribute_group_link (
    attribute_group_link_id integer NOT NULL,
    attribute_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.attribute_group_link OWNER TO postgres;

--
-- Name: attribute_group_link_attribute_group_link_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.attribute_group_link ALTER COLUMN attribute_group_link_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.attribute_group_link_attribute_group_link_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: attribute_option; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attribute_option (
    attribute_option_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    attribute_id integer NOT NULL,
    attribute_code character varying NOT NULL,
    option_text character varying NOT NULL
);


ALTER TABLE public.attribute_option OWNER TO postgres;

--
-- Name: attribute_option_attribute_option_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.attribute_option ALTER COLUMN attribute_option_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.attribute_option_attribute_option_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: cart; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart (
    cart_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    sid character varying,
    currency character varying NOT NULL,
    customer_id integer,
    customer_group_id smallint,
    customer_email character varying,
    customer_full_name character varying,
    user_ip character varying,
    status boolean DEFAULT false NOT NULL,
    coupon character varying,
    shipping_fee_excl_tax numeric(12,4) DEFAULT NULL::numeric,
    shipping_fee_incl_tax numeric(12,4) DEFAULT NULL::numeric,
    discount_amount numeric(12,4) DEFAULT NULL::numeric,
    sub_total numeric(12,4) NOT NULL,
    sub_total_incl_tax numeric(12,4) NOT NULL,
    total_qty integer NOT NULL,
    total_weight numeric(12,4) DEFAULT NULL::numeric,
    tax_amount numeric(12,4) NOT NULL,
    grand_total numeric(12,4) NOT NULL,
    shipping_method character varying,
    shipping_method_name character varying,
    shipping_zone_id integer,
    shipping_address_id integer,
    payment_method character varying,
    payment_method_name character varying,
    billing_address_id integer,
    shipping_note text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.cart OWNER TO postgres;

--
-- Name: cart_address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart_address (
    cart_address_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    full_name character varying,
    postcode character varying,
    telephone character varying,
    country character varying,
    province character varying,
    city character varying,
    address_1 character varying,
    address_2 character varying
);


ALTER TABLE public.cart_address OWNER TO postgres;

--
-- Name: cart_address_cart_address_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.cart_address ALTER COLUMN cart_address_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.cart_address_cart_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: cart_cart_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.cart ALTER COLUMN cart_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.cart_cart_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: cart_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart_item (
    cart_item_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    cart_id integer NOT NULL,
    product_id integer NOT NULL,
    product_sku character varying NOT NULL,
    product_name text NOT NULL,
    thumbnail character varying,
    product_weight numeric(12,4) DEFAULT NULL::numeric,
    product_price numeric(12,4) NOT NULL,
    product_price_incl_tax numeric(12,4) NOT NULL,
    qty integer NOT NULL,
    final_price numeric(12,4) NOT NULL,
    final_price_incl_tax numeric(12,4) NOT NULL,
    tax_percent numeric(12,4) NOT NULL,
    tax_amount numeric(12,4) NOT NULL,
    discount_amount numeric(12,4) NOT NULL,
    sub_total numeric(12,4) NOT NULL,
    total numeric(12,4) NOT NULL,
    variant_group_id integer,
    variant_options text,
    product_custom_options text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.cart_item OWNER TO postgres;

--
-- Name: cart_item_cart_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.cart_item ALTER COLUMN cart_item_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.cart_item_cart_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category (
    category_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    status boolean NOT NULL,
    parent_id integer,
    include_in_nav boolean NOT NULL,
    "position" smallint,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.category OWNER TO postgres;

--
-- Name: category_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.category ALTER COLUMN category_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.category_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: category_description; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category_description (
    category_description_id integer NOT NULL,
    category_description_category_id integer NOT NULL,
    name character varying NOT NULL,
    short_description text,
    description text,
    image character varying,
    meta_title text,
    meta_keywords text,
    meta_description text,
    url_key character varying NOT NULL
);


ALTER TABLE public.category_description OWNER TO postgres;

--
-- Name: category_description_category_description_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.category_description ALTER COLUMN category_description_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.category_description_category_description_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: cms_page; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cms_page (
    cms_page_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    layout character varying NOT NULL,
    status boolean,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.cms_page OWNER TO postgres;

--
-- Name: cms_page_cms_page_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.cms_page ALTER COLUMN cms_page_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.cms_page_cms_page_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: cms_page_description; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cms_page_description (
    cms_page_description_id integer NOT NULL,
    cms_page_description_cms_page_id integer,
    url_key character varying NOT NULL,
    name character varying NOT NULL,
    content text,
    meta_title character varying,
    meta_keywords character varying,
    meta_description text
);


ALTER TABLE public.cms_page_description OWNER TO postgres;

--
-- Name: cms_page_description_cms_page_description_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.cms_page_description ALTER COLUMN cms_page_description_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.cms_page_description_cms_page_description_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: collection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.collection (
    collection_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying NOT NULL,
    description text,
    code character varying NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.collection OWNER TO postgres;

--
-- Name: collection_collection_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.collection ALTER COLUMN collection_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.collection_collection_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: coupon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.coupon (
    coupon_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    status boolean DEFAULT true NOT NULL,
    description character varying NOT NULL,
    discount_amount numeric(12,4) NOT NULL,
    free_shipping boolean DEFAULT false NOT NULL,
    discount_type character varying DEFAULT '1'::character varying NOT NULL,
    coupon character varying NOT NULL,
    used_time integer DEFAULT 0 NOT NULL,
    target_products jsonb,
    condition jsonb,
    user_condition jsonb,
    buyx_gety jsonb,
    max_uses_time_per_coupon integer,
    max_uses_time_per_customer integer,
    start_date timestamp with time zone,
    end_date timestamp with time zone,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "POSITIVE_DISCOUNT_AMOUNT" CHECK ((discount_amount >= (0)::numeric)),
    CONSTRAINT "VALID_PERCENTAGE_DISCOUNT" CHECK (((discount_amount <= (100)::numeric) OR ((discount_type)::text <> 'percentage'::text)))
);


ALTER TABLE public.coupon OWNER TO postgres;

--
-- Name: coupon_coupon_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.coupon ALTER COLUMN coupon_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.coupon_coupon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer (
    customer_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    status smallint DEFAULT 1 NOT NULL,
    group_id integer DEFAULT 1,
    email character varying NOT NULL,
    password character varying NOT NULL,
    full_name character varying,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.customer OWNER TO postgres;

--
-- Name: customer_address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_address (
    customer_address_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    customer_id integer NOT NULL,
    full_name character varying,
    telephone character varying,
    address_1 character varying,
    address_2 character varying,
    postcode character varying,
    city character varying,
    province character varying,
    country character varying NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    is_default smallint
);


ALTER TABLE public.customer_address OWNER TO postgres;

--
-- Name: customer_address_customer_address_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.customer_address ALTER COLUMN customer_address_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.customer_address_customer_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: customer_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.customer ALTER COLUMN customer_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.customer_customer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: customer_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_group (
    customer_group_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    group_name character varying NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.customer_group OWNER TO postgres;

--
-- Name: customer_group_customer_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.customer_group ALTER COLUMN customer_group_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.customer_group_customer_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: event; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event (
    event_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying NOT NULL,
    data json,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.event OWNER TO postgres;

--
-- Name: event_event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.event ALTER COLUMN event_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.event_event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: migration; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migration (
    migration_id integer NOT NULL,
    module character varying NOT NULL,
    version character varying NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.migration OWNER TO postgres;

--
-- Name: migration_migration_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.migration ALTER COLUMN migration_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.migration_migration_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."order" (
    order_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    integration_order_id character varying,
    sid character varying,
    order_number character varying NOT NULL,
    cart_id integer NOT NULL,
    currency character varying NOT NULL,
    customer_id integer,
    customer_email character varying,
    customer_full_name character varying,
    user_ip character varying,
    user_agent character varying,
    coupon character varying,
    shipping_fee_excl_tax numeric(12,4) DEFAULT NULL::numeric,
    shipping_fee_incl_tax numeric(12,4) DEFAULT NULL::numeric,
    discount_amount numeric(12,4) DEFAULT NULL::numeric,
    sub_total numeric(12,4) NOT NULL,
    sub_total_incl_tax numeric(12,4) NOT NULL,
    total_qty integer NOT NULL,
    total_weight numeric(12,4) DEFAULT NULL::numeric,
    tax_amount numeric(12,4) NOT NULL,
    shipping_note text,
    grand_total numeric(12,4) NOT NULL,
    shipping_method character varying,
    shipping_method_name character varying,
    shipping_address_id integer,
    payment_method character varying,
    payment_method_name character varying,
    billing_address_id integer,
    shipment_status character varying,
    payment_status character varying,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public."order" OWNER TO postgres;

--
-- Name: order_activity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_activity (
    order_activity_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    order_activity_order_id integer NOT NULL,
    comment text NOT NULL,
    customer_notified boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.order_activity OWNER TO postgres;

--
-- Name: order_activity_order_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.order_activity ALTER COLUMN order_activity_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.order_activity_order_activity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: order_address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_address (
    order_address_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    full_name character varying,
    postcode character varying,
    telephone character varying,
    country character varying,
    province character varying,
    city character varying,
    address_1 character varying,
    address_2 character varying
);


ALTER TABLE public.order_address OWNER TO postgres;

--
-- Name: order_address_order_address_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.order_address ALTER COLUMN order_address_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.order_address_order_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: order_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_item (
    order_item_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    order_item_order_id integer NOT NULL,
    product_id integer NOT NULL,
    referer integer,
    product_sku character varying NOT NULL,
    product_name text NOT NULL,
    thumbnail character varying,
    product_weight numeric(12,4) DEFAULT NULL::numeric,
    product_price numeric(12,4) NOT NULL,
    product_price_incl_tax numeric(12,4) NOT NULL,
    qty integer NOT NULL,
    final_price numeric(12,4) NOT NULL,
    final_price_incl_tax numeric(12,4) NOT NULL,
    tax_percent numeric(12,4) NOT NULL,
    tax_amount numeric(12,4) NOT NULL,
    discount_amount numeric(12,4) NOT NULL,
    sub_total numeric(12,4) NOT NULL,
    total numeric(12,4) NOT NULL,
    variant_group_id integer,
    variant_options text,
    product_custom_options text,
    requested_data text
);


ALTER TABLE public.order_item OWNER TO postgres;

--
-- Name: order_item_order_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.order_item ALTER COLUMN order_item_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.order_item_order_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: order_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."order" ALTER COLUMN order_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.order_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: payment_transaction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_transaction (
    payment_transaction_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    payment_transaction_order_id integer NOT NULL,
    transaction_id character varying,
    transaction_type character varying NOT NULL,
    amount numeric(12,4) NOT NULL,
    parent_transaction_id character varying,
    payment_action character varying,
    additional_information text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.payment_transaction OWNER TO postgres;

--
-- Name: payment_transaction_payment_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.payment_transaction ALTER COLUMN payment_transaction_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.payment_transaction_payment_transaction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    product_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    type character varying DEFAULT 'simple'::character varying NOT NULL,
    variant_group_id integer,
    visibility boolean DEFAULT true NOT NULL,
    group_id integer DEFAULT 1,
    sku character varying NOT NULL,
    price numeric(12,4) NOT NULL,
    weight numeric(12,4) DEFAULT NULL::numeric,
    tax_class smallint,
    status boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    category_id integer,
    brand text,
    powersource text,
    usefor text,
    itemweight text,
    material text,
    color text,
    specialfeature text,
    specificusesforproduct text,
    productbenefits text,
    productdimensions text,
    companydetails text,
    video text,
    CONSTRAINT "UNSIGNED_PRICE" CHECK ((price >= (0)::numeric)),
    CONSTRAINT "UNSIGNED_WEIGHT" CHECK ((weight >= (0)::numeric))
);


ALTER TABLE public.product OWNER TO postgres;

--
-- Name: product_attribute_value_index; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_attribute_value_index (
    product_attribute_value_index_id integer NOT NULL,
    product_id integer NOT NULL,
    attribute_id integer NOT NULL,
    option_id integer,
    option_text text
);


ALTER TABLE public.product_attribute_value_index OWNER TO postgres;

--
-- Name: product_attribute_value_index_product_attribute_value_index_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.product_attribute_value_index ALTER COLUMN product_attribute_value_index_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.product_attribute_value_index_product_attribute_value_index_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: product_collection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_collection (
    product_collection_id integer NOT NULL,
    collection_id integer NOT NULL,
    product_id integer NOT NULL
);


ALTER TABLE public.product_collection OWNER TO postgres;

--
-- Name: product_collection_product_collection_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.product_collection ALTER COLUMN product_collection_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.product_collection_product_collection_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: product_custom_option; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_custom_option (
    product_custom_option_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    product_custom_option_product_id integer NOT NULL,
    option_name character varying NOT NULL,
    option_type character varying NOT NULL,
    is_required boolean DEFAULT false NOT NULL,
    sort_order integer
);


ALTER TABLE public.product_custom_option OWNER TO postgres;

--
-- Name: product_custom_option_product_custom_option_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.product_custom_option ALTER COLUMN product_custom_option_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.product_custom_option_product_custom_option_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: product_custom_option_value; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_custom_option_value (
    product_custom_option_value_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    option_id integer NOT NULL,
    extra_price numeric(12,4) DEFAULT NULL::numeric,
    sort_order integer,
    value character varying NOT NULL
);


ALTER TABLE public.product_custom_option_value OWNER TO postgres;

--
-- Name: product_custom_option_value_product_custom_option_value_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.product_custom_option_value ALTER COLUMN product_custom_option_value_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.product_custom_option_value_product_custom_option_value_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: product_description; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_description (
    product_description_id integer NOT NULL,
    product_description_product_id integer NOT NULL,
    name character varying NOT NULL,
    description text,
    short_description text,
    url_key character varying NOT NULL,
    meta_title text,
    meta_description text,
    meta_keywords text
);


ALTER TABLE public.product_description OWNER TO postgres;

--
-- Name: product_description_product_description_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.product_description ALTER COLUMN product_description_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.product_description_product_description_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: product_image; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_image (
    product_image_id integer NOT NULL,
    product_image_product_id integer NOT NULL,
    origin_image character varying NOT NULL,
    thumb_image text,
    listing_image text,
    single_image text,
    is_main boolean DEFAULT false
);


ALTER TABLE public.product_image OWNER TO postgres;

--
-- Name: product_image_product_image_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.product_image ALTER COLUMN product_image_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.product_image_product_image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: product_inventory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_inventory (
    product_inventory_id integer NOT NULL,
    product_inventory_product_id integer NOT NULL,
    qty integer DEFAULT 0 NOT NULL,
    manage_stock boolean DEFAULT false NOT NULL,
    stock_availability boolean DEFAULT false NOT NULL
);


ALTER TABLE public.product_inventory OWNER TO postgres;

--
-- Name: product_inventory_product_inventory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.product_inventory ALTER COLUMN product_inventory_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.product_inventory_product_inventory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: product_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.product ALTER COLUMN product_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.product_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: reset_password_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reset_password_token (
    reset_password_token_id integer NOT NULL,
    customer_id integer NOT NULL,
    token text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.reset_password_token OWNER TO postgres;

--
-- Name: reset_password_token_reset_password_token_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.reset_password_token ALTER COLUMN reset_password_token_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.reset_password_token_reset_password_token_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.session (
    sid character varying NOT NULL,
    sess json NOT NULL,
    expire timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.session OWNER TO postgres;

--
-- Name: setting; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.setting (
    setting_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying NOT NULL,
    value text,
    is_json boolean DEFAULT false NOT NULL
);


ALTER TABLE public.setting OWNER TO postgres;

--
-- Name: setting_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.setting ALTER COLUMN setting_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.setting_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: shipment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipment (
    shipment_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    shipment_order_id integer NOT NULL,
    carrier character varying,
    tracking_number character varying,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.shipment OWNER TO postgres;

--
-- Name: shipment_shipment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.shipment ALTER COLUMN shipment_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.shipment_shipment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: shipping_method; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipping_method (
    shipping_method_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.shipping_method OWNER TO postgres;

--
-- Name: shipping_method_shipping_method_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.shipping_method ALTER COLUMN shipping_method_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.shipping_method_shipping_method_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: shipping_zone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipping_zone (
    shipping_zone_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying NOT NULL,
    country character varying NOT NULL
);


ALTER TABLE public.shipping_zone OWNER TO postgres;

--
-- Name: shipping_zone_method; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipping_zone_method (
    shipping_zone_method_id integer NOT NULL,
    method_id integer NOT NULL,
    zone_id integer NOT NULL,
    is_enabled boolean DEFAULT true NOT NULL,
    cost numeric(12,4) DEFAULT NULL::numeric,
    calculate_api character varying,
    condition_type character varying,
    max numeric(12,4) DEFAULT NULL::numeric,
    min numeric(12,4) DEFAULT NULL::numeric,
    price_based_cost jsonb,
    weight_based_cost jsonb
);


ALTER TABLE public.shipping_zone_method OWNER TO postgres;

--
-- Name: shipping_zone_method_shipping_zone_method_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.shipping_zone_method ALTER COLUMN shipping_zone_method_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.shipping_zone_method_shipping_zone_method_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: shipping_zone_province; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipping_zone_province (
    shipping_zone_province_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    zone_id integer NOT NULL,
    province character varying NOT NULL
);


ALTER TABLE public.shipping_zone_province OWNER TO postgres;

--
-- Name: shipping_zone_province_shipping_zone_province_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.shipping_zone_province ALTER COLUMN shipping_zone_province_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.shipping_zone_province_shipping_zone_province_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: shipping_zone_shipping_zone_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.shipping_zone ALTER COLUMN shipping_zone_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.shipping_zone_shipping_zone_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tax_class; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tax_class (
    tax_class_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.tax_class OWNER TO postgres;

--
-- Name: tax_class_tax_class_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.tax_class ALTER COLUMN tax_class_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tax_class_tax_class_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tax_rate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tax_rate (
    tax_rate_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying NOT NULL,
    tax_class_id integer,
    country character varying DEFAULT '*'::character varying NOT NULL,
    province character varying DEFAULT '*'::character varying NOT NULL,
    postcode character varying DEFAULT '*'::character varying NOT NULL,
    rate numeric(12,4) NOT NULL,
    is_compound boolean DEFAULT false NOT NULL,
    priority integer NOT NULL,
    CONSTRAINT "UNSIGNED_PRIORITY" CHECK ((priority >= 0)),
    CONSTRAINT "UNSIGNED_RATE" CHECK ((rate >= (0)::numeric))
);


ALTER TABLE public.tax_rate OWNER TO postgres;

--
-- Name: tax_rate_tax_rate_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.tax_rate ALTER COLUMN tax_rate_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tax_rate_tax_rate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: url_rewrite; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.url_rewrite (
    url_rewrite_id integer NOT NULL,
    language character varying DEFAULT 'en'::character varying NOT NULL,
    request_path character varying NOT NULL,
    target_path character varying NOT NULL,
    entity_uuid uuid,
    entity_type character varying
);


ALTER TABLE public.url_rewrite OWNER TO postgres;

--
-- Name: url_rewrite_url_rewrite_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.url_rewrite ALTER COLUMN url_rewrite_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.url_rewrite_url_rewrite_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: variant_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.variant_group (
    variant_group_id integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    attribute_group_id integer NOT NULL,
    attribute_one integer,
    attribute_two integer,
    attribute_three integer,
    attribute_four integer,
    attribute_five integer,
    visibility boolean DEFAULT false NOT NULL
);


ALTER TABLE public.variant_group OWNER TO postgres;

--
-- Name: variant_group_variant_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.variant_group ALTER COLUMN variant_group_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.variant_group_variant_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: admin_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_user (admin_user_id, uuid, status, email, password, full_name, created_at, updated_at) FROM stdin;
\.
COPY public.admin_user (admin_user_id, uuid, status, email, password, full_name, created_at, updated_at) FROM '$$PATH$$/3962.dat';

--
-- Data for Name: attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attribute (attribute_id, uuid, attribute_code, attribute_name, type, is_required, display_on_frontend, sort_order, is_filterable) FROM stdin;
\.
COPY public.attribute (attribute_id, uuid, attribute_code, attribute_name, type, is_required, display_on_frontend, sort_order, is_filterable) FROM '$$PATH$$/3964.dat';

--
-- Data for Name: attribute_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attribute_group (attribute_group_id, uuid, group_name, created_at, updated_at) FROM stdin;
\.
COPY public.attribute_group (attribute_group_id, uuid, group_name, created_at, updated_at) FROM '$$PATH$$/3966.dat';

--
-- Data for Name: attribute_group_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attribute_group_link (attribute_group_link_id, attribute_id, group_id) FROM stdin;
\.
COPY public.attribute_group_link (attribute_group_link_id, attribute_id, group_id) FROM '$$PATH$$/3968.dat';

--
-- Data for Name: attribute_option; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attribute_option (attribute_option_id, uuid, attribute_id, attribute_code, option_text) FROM stdin;
\.
COPY public.attribute_option (attribute_option_id, uuid, attribute_id, attribute_code, option_text) FROM '$$PATH$$/3970.dat';

--
-- Data for Name: cart; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart (cart_id, uuid, sid, currency, customer_id, customer_group_id, customer_email, customer_full_name, user_ip, status, coupon, shipping_fee_excl_tax, shipping_fee_incl_tax, discount_amount, sub_total, sub_total_incl_tax, total_qty, total_weight, tax_amount, grand_total, shipping_method, shipping_method_name, shipping_zone_id, shipping_address_id, payment_method, payment_method_name, billing_address_id, shipping_note, created_at, updated_at) FROM stdin;
\.
COPY public.cart (cart_id, uuid, sid, currency, customer_id, customer_group_id, customer_email, customer_full_name, user_ip, status, coupon, shipping_fee_excl_tax, shipping_fee_incl_tax, discount_amount, sub_total, sub_total_incl_tax, total_qty, total_weight, tax_amount, grand_total, shipping_method, shipping_method_name, shipping_zone_id, shipping_address_id, payment_method, payment_method_name, billing_address_id, shipping_note, created_at, updated_at) FROM '$$PATH$$/3972.dat';

--
-- Data for Name: cart_address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart_address (cart_address_id, uuid, full_name, postcode, telephone, country, province, city, address_1, address_2) FROM stdin;
\.
COPY public.cart_address (cart_address_id, uuid, full_name, postcode, telephone, country, province, city, address_1, address_2) FROM '$$PATH$$/3973.dat';

--
-- Data for Name: cart_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart_item (cart_item_id, uuid, cart_id, product_id, product_sku, product_name, thumbnail, product_weight, product_price, product_price_incl_tax, qty, final_price, final_price_incl_tax, tax_percent, tax_amount, discount_amount, sub_total, total, variant_group_id, variant_options, product_custom_options, created_at, updated_at) FROM stdin;
\.
COPY public.cart_item (cart_item_id, uuid, cart_id, product_id, product_sku, product_name, thumbnail, product_weight, product_price, product_price_incl_tax, qty, final_price, final_price_incl_tax, tax_percent, tax_amount, discount_amount, sub_total, total, variant_group_id, variant_options, product_custom_options, created_at, updated_at) FROM '$$PATH$$/3976.dat';

--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.category (category_id, uuid, status, parent_id, include_in_nav, "position", created_at, updated_at) FROM stdin;
\.
COPY public.category (category_id, uuid, status, parent_id, include_in_nav, "position", created_at, updated_at) FROM '$$PATH$$/3978.dat';

--
-- Data for Name: category_description; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.category_description (category_description_id, category_description_category_id, name, short_description, description, image, meta_title, meta_keywords, meta_description, url_key) FROM stdin;
\.
COPY public.category_description (category_description_id, category_description_category_id, name, short_description, description, image, meta_title, meta_keywords, meta_description, url_key) FROM '$$PATH$$/3980.dat';

--
-- Data for Name: cms_page; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cms_page (cms_page_id, uuid, layout, status, created_at, updated_at) FROM stdin;
\.
COPY public.cms_page (cms_page_id, uuid, layout, status, created_at, updated_at) FROM '$$PATH$$/3982.dat';

--
-- Data for Name: cms_page_description; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cms_page_description (cms_page_description_id, cms_page_description_cms_page_id, url_key, name, content, meta_title, meta_keywords, meta_description) FROM stdin;
\.
COPY public.cms_page_description (cms_page_description_id, cms_page_description_cms_page_id, url_key, name, content, meta_title, meta_keywords, meta_description) FROM '$$PATH$$/3984.dat';

--
-- Data for Name: collection; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.collection (collection_id, uuid, name, description, code, created_at, updated_at) FROM stdin;
\.
COPY public.collection (collection_id, uuid, name, description, code, created_at, updated_at) FROM '$$PATH$$/3986.dat';

--
-- Data for Name: coupon; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.coupon (coupon_id, uuid, status, description, discount_amount, free_shipping, discount_type, coupon, used_time, target_products, condition, user_condition, buyx_gety, max_uses_time_per_coupon, max_uses_time_per_customer, start_date, end_date, created_at, updated_at) FROM stdin;
\.
COPY public.coupon (coupon_id, uuid, status, description, discount_amount, free_shipping, discount_type, coupon, used_time, target_products, condition, user_condition, buyx_gety, max_uses_time_per_coupon, max_uses_time_per_customer, start_date, end_date, created_at, updated_at) FROM '$$PATH$$/3988.dat';

--
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer (customer_id, uuid, status, group_id, email, password, full_name, created_at, updated_at) FROM stdin;
\.
COPY public.customer (customer_id, uuid, status, group_id, email, password, full_name, created_at, updated_at) FROM '$$PATH$$/3990.dat';

--
-- Data for Name: customer_address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer_address (customer_address_id, uuid, customer_id, full_name, telephone, address_1, address_2, postcode, city, province, country, created_at, updated_at, is_default) FROM stdin;
\.
COPY public.customer_address (customer_address_id, uuid, customer_id, full_name, telephone, address_1, address_2, postcode, city, province, country, created_at, updated_at, is_default) FROM '$$PATH$$/3991.dat';

--
-- Data for Name: customer_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer_group (customer_group_id, uuid, group_name, created_at, updated_at) FROM stdin;
\.
COPY public.customer_group (customer_group_id, uuid, group_name, created_at, updated_at) FROM '$$PATH$$/3994.dat';

--
-- Data for Name: event; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event (event_id, uuid, name, data, created_at) FROM stdin;
\.
COPY public.event (event_id, uuid, name, data, created_at) FROM '$$PATH$$/3996.dat';

--
-- Data for Name: migration; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migration (migration_id, module, version, created_at, updated_at) FROM stdin;
\.
COPY public.migration (migration_id, module, version, created_at, updated_at) FROM '$$PATH$$/3998.dat';

--
-- Data for Name: order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."order" (order_id, uuid, integration_order_id, sid, order_number, cart_id, currency, customer_id, customer_email, customer_full_name, user_ip, user_agent, coupon, shipping_fee_excl_tax, shipping_fee_incl_tax, discount_amount, sub_total, sub_total_incl_tax, total_qty, total_weight, tax_amount, shipping_note, grand_total, shipping_method, shipping_method_name, shipping_address_id, payment_method, payment_method_name, billing_address_id, shipment_status, payment_status, created_at, updated_at) FROM stdin;
\.
COPY public."order" (order_id, uuid, integration_order_id, sid, order_number, cart_id, currency, customer_id, customer_email, customer_full_name, user_ip, user_agent, coupon, shipping_fee_excl_tax, shipping_fee_incl_tax, discount_amount, sub_total, sub_total_incl_tax, total_qty, total_weight, tax_amount, shipping_note, grand_total, shipping_method, shipping_method_name, shipping_address_id, payment_method, payment_method_name, billing_address_id, shipment_status, payment_status, created_at, updated_at) FROM '$$PATH$$/4000.dat';

--
-- Data for Name: order_activity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_activity (order_activity_id, uuid, order_activity_order_id, comment, customer_notified, created_at, updated_at) FROM stdin;
\.
COPY public.order_activity (order_activity_id, uuid, order_activity_order_id, comment, customer_notified, created_at, updated_at) FROM '$$PATH$$/4001.dat';

--
-- Data for Name: order_address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_address (order_address_id, uuid, full_name, postcode, telephone, country, province, city, address_1, address_2) FROM stdin;
\.
COPY public.order_address (order_address_id, uuid, full_name, postcode, telephone, country, province, city, address_1, address_2) FROM '$$PATH$$/4003.dat';

--
-- Data for Name: order_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_item (order_item_id, uuid, order_item_order_id, product_id, referer, product_sku, product_name, thumbnail, product_weight, product_price, product_price_incl_tax, qty, final_price, final_price_incl_tax, tax_percent, tax_amount, discount_amount, sub_total, total, variant_group_id, variant_options, product_custom_options, requested_data) FROM stdin;
\.
COPY public.order_item (order_item_id, uuid, order_item_order_id, product_id, referer, product_sku, product_name, thumbnail, product_weight, product_price, product_price_incl_tax, qty, final_price, final_price_incl_tax, tax_percent, tax_amount, discount_amount, sub_total, total, variant_group_id, variant_options, product_custom_options, requested_data) FROM '$$PATH$$/4005.dat';

--
-- Data for Name: payment_transaction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_transaction (payment_transaction_id, uuid, payment_transaction_order_id, transaction_id, transaction_type, amount, parent_transaction_id, payment_action, additional_information, created_at) FROM stdin;
\.
COPY public.payment_transaction (payment_transaction_id, uuid, payment_transaction_order_id, transaction_id, transaction_type, amount, parent_transaction_id, payment_action, additional_information, created_at) FROM '$$PATH$$/4008.dat';

--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product (product_id, uuid, type, variant_group_id, visibility, group_id, sku, price, weight, tax_class, status, created_at, updated_at, category_id, brand, powersource, usefor, itemweight, material, color, specialfeature, specificusesforproduct, productbenefits, productdimensions, companydetails, video) FROM stdin;
\.
COPY public.product (product_id, uuid, type, variant_group_id, visibility, group_id, sku, price, weight, tax_class, status, created_at, updated_at, category_id, brand, powersource, usefor, itemweight, material, color, specialfeature, specificusesforproduct, productbenefits, productdimensions, companydetails, video) FROM '$$PATH$$/4010.dat';

--
-- Data for Name: product_attribute_value_index; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_attribute_value_index (product_attribute_value_index_id, product_id, attribute_id, option_id, option_text) FROM stdin;
\.
COPY public.product_attribute_value_index (product_attribute_value_index_id, product_id, attribute_id, option_id, option_text) FROM '$$PATH$$/4011.dat';

--
-- Data for Name: product_collection; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_collection (product_collection_id, collection_id, product_id) FROM stdin;
\.
COPY public.product_collection (product_collection_id, collection_id, product_id) FROM '$$PATH$$/4013.dat';

--
-- Data for Name: product_custom_option; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_custom_option (product_custom_option_id, uuid, product_custom_option_product_id, option_name, option_type, is_required, sort_order) FROM stdin;
\.
COPY public.product_custom_option (product_custom_option_id, uuid, product_custom_option_product_id, option_name, option_type, is_required, sort_order) FROM '$$PATH$$/4015.dat';

--
-- Data for Name: product_custom_option_value; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_custom_option_value (product_custom_option_value_id, uuid, option_id, extra_price, sort_order, value) FROM stdin;
\.
COPY public.product_custom_option_value (product_custom_option_value_id, uuid, option_id, extra_price, sort_order, value) FROM '$$PATH$$/4017.dat';

--
-- Data for Name: product_description; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_description (product_description_id, product_description_product_id, name, description, short_description, url_key, meta_title, meta_description, meta_keywords) FROM stdin;
\.
COPY public.product_description (product_description_id, product_description_product_id, name, description, short_description, url_key, meta_title, meta_description, meta_keywords) FROM '$$PATH$$/4019.dat';

--
-- Data for Name: product_image; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_image (product_image_id, product_image_product_id, origin_image, thumb_image, listing_image, single_image, is_main) FROM stdin;
\.
COPY public.product_image (product_image_id, product_image_product_id, origin_image, thumb_image, listing_image, single_image, is_main) FROM '$$PATH$$/4021.dat';

--
-- Data for Name: product_inventory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_inventory (product_inventory_id, product_inventory_product_id, qty, manage_stock, stock_availability) FROM stdin;
\.
COPY public.product_inventory (product_inventory_id, product_inventory_product_id, qty, manage_stock, stock_availability) FROM '$$PATH$$/4023.dat';

--
-- Data for Name: reset_password_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reset_password_token (reset_password_token_id, customer_id, token, created_at) FROM stdin;
\.
COPY public.reset_password_token (reset_password_token_id, customer_id, token, created_at) FROM '$$PATH$$/4026.dat';

--
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.session (sid, sess, expire) FROM stdin;
\.
COPY public.session (sid, sess, expire) FROM '$$PATH$$/4028.dat';

--
-- Data for Name: setting; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.setting (setting_id, uuid, name, value, is_json) FROM stdin;
\.
COPY public.setting (setting_id, uuid, name, value, is_json) FROM '$$PATH$$/4029.dat';

--
-- Data for Name: shipment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shipment (shipment_id, uuid, shipment_order_id, carrier, tracking_number, created_at, updated_at) FROM stdin;
\.
COPY public.shipment (shipment_id, uuid, shipment_order_id, carrier, tracking_number, created_at, updated_at) FROM '$$PATH$$/4031.dat';

--
-- Data for Name: shipping_method; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shipping_method (shipping_method_id, uuid, name) FROM stdin;
\.
COPY public.shipping_method (shipping_method_id, uuid, name) FROM '$$PATH$$/4033.dat';

--
-- Data for Name: shipping_zone; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shipping_zone (shipping_zone_id, uuid, name, country) FROM stdin;
\.
COPY public.shipping_zone (shipping_zone_id, uuid, name, country) FROM '$$PATH$$/4035.dat';

--
-- Data for Name: shipping_zone_method; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shipping_zone_method (shipping_zone_method_id, method_id, zone_id, is_enabled, cost, calculate_api, condition_type, max, min, price_based_cost, weight_based_cost) FROM stdin;
\.
COPY public.shipping_zone_method (shipping_zone_method_id, method_id, zone_id, is_enabled, cost, calculate_api, condition_type, max, min, price_based_cost, weight_based_cost) FROM '$$PATH$$/4036.dat';

--
-- Data for Name: shipping_zone_province; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shipping_zone_province (shipping_zone_province_id, uuid, zone_id, province) FROM stdin;
\.
COPY public.shipping_zone_province (shipping_zone_province_id, uuid, zone_id, province) FROM '$$PATH$$/4038.dat';

--
-- Data for Name: tax_class; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tax_class (tax_class_id, uuid, name) FROM stdin;
\.
COPY public.tax_class (tax_class_id, uuid, name) FROM '$$PATH$$/4041.dat';

--
-- Data for Name: tax_rate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tax_rate (tax_rate_id, uuid, name, tax_class_id, country, province, postcode, rate, is_compound, priority) FROM stdin;
\.
COPY public.tax_rate (tax_rate_id, uuid, name, tax_class_id, country, province, postcode, rate, is_compound, priority) FROM '$$PATH$$/4043.dat';

--
-- Data for Name: url_rewrite; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.url_rewrite (url_rewrite_id, language, request_path, target_path, entity_uuid, entity_type) FROM stdin;
\.
COPY public.url_rewrite (url_rewrite_id, language, request_path, target_path, entity_uuid, entity_type) FROM '$$PATH$$/4045.dat';

--
-- Data for Name: variant_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.variant_group (variant_group_id, uuid, attribute_group_id, attribute_one, attribute_two, attribute_three, attribute_four, attribute_five, visibility) FROM stdin;
\.
COPY public.variant_group (variant_group_id, uuid, attribute_group_id, attribute_one, attribute_two, attribute_three, attribute_four, attribute_five, visibility) FROM '$$PATH$$/4047.dat';

--
-- Name: admin_user_admin_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_user_admin_user_id_seq', 2, true);


--
-- Name: attribute_attribute_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attribute_attribute_id_seq', 2, true);


--
-- Name: attribute_group_attribute_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attribute_group_attribute_group_id_seq', 1, true);


--
-- Name: attribute_group_link_attribute_group_link_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attribute_group_link_attribute_group_link_id_seq', 2, true);


--
-- Name: attribute_option_attribute_option_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attribute_option_attribute_option_id_seq', 6, true);


--
-- Name: cart_address_cart_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cart_address_cart_address_id_seq', 15, true);


--
-- Name: cart_cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cart_cart_id_seq', 10, true);


--
-- Name: cart_item_cart_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cart_item_cart_item_id_seq', 15, true);


--
-- Name: category_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.category_category_id_seq', 26, true);


--
-- Name: category_description_category_description_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.category_description_category_description_id_seq', 26, true);


--
-- Name: cms_page_cms_page_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cms_page_cms_page_id_seq', 8, true);


--
-- Name: cms_page_description_cms_page_description_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cms_page_description_cms_page_description_id_seq', 8, true);


--
-- Name: collection_collection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.collection_collection_id_seq', 6, true);


--
-- Name: coupon_coupon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.coupon_coupon_id_seq', 1, true);


--
-- Name: customer_address_customer_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_address_customer_address_id_seq', 1, false);


--
-- Name: customer_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_customer_id_seq', 1, true);


--
-- Name: customer_group_customer_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_group_customer_group_id_seq', 1, true);


--
-- Name: event_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.event_event_id_seq', 635, true);


--
-- Name: migration_migration_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migration_migration_id_seq', 25, true);


--
-- Name: order_activity_order_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_activity_order_activity_id_seq', 3, true);


--
-- Name: order_address_order_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_address_order_address_id_seq', 4, true);


--
-- Name: order_item_order_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_item_order_item_id_seq', 2, true);


--
-- Name: order_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_order_id_seq', 2, true);


--
-- Name: payment_transaction_payment_transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payment_transaction_payment_transaction_id_seq', 1, true);


--
-- Name: product_attribute_value_index_product_attribute_value_index_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_attribute_value_index_product_attribute_value_index_seq', 276, true);


--
-- Name: product_collection_product_collection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_collection_product_collection_id_seq', 15, true);


--
-- Name: product_custom_option_product_custom_option_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_custom_option_product_custom_option_id_seq', 1, false);


--
-- Name: product_custom_option_value_product_custom_option_value_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_custom_option_value_product_custom_option_value_id_seq', 1, false);


--
-- Name: product_description_product_description_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_description_product_description_id_seq', 33, true);


--
-- Name: product_image_product_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_image_product_image_id_seq', 130, true);


--
-- Name: product_inventory_product_inventory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_inventory_product_inventory_id_seq', 32, true);


--
-- Name: product_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_product_id_seq', 41, true);


--
-- Name: reset_password_token_reset_password_token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reset_password_token_reset_password_token_id_seq', 1, false);


--
-- Name: setting_setting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.setting_setting_id_seq', 12, true);


--
-- Name: shipment_shipment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shipment_shipment_id_seq', 1, false);


--
-- Name: shipping_method_shipping_method_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shipping_method_shipping_method_id_seq', 1, true);


--
-- Name: shipping_zone_method_shipping_zone_method_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shipping_zone_method_shipping_zone_method_id_seq', 2, true);


--
-- Name: shipping_zone_province_shipping_zone_province_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shipping_zone_province_shipping_zone_province_id_seq', 1, false);


--
-- Name: shipping_zone_shipping_zone_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shipping_zone_shipping_zone_id_seq', 2, true);


--
-- Name: tax_class_tax_class_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tax_class_tax_class_id_seq', 1, true);


--
-- Name: tax_rate_tax_rate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tax_rate_tax_rate_id_seq', 1, true);


--
-- Name: url_rewrite_url_rewrite_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.url_rewrite_url_rewrite_id_seq', 524, true);


--
-- Name: variant_group_variant_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.variant_group_variant_group_id_seq', 5, true);


--
-- Name: admin_user ADMIN_USER_EMAIL_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_user
    ADD CONSTRAINT "ADMIN_USER_EMAIL_UNIQUE" UNIQUE (email);


--
-- Name: admin_user ADMIN_USER_UUID_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_user
    ADD CONSTRAINT "ADMIN_USER_UUID_UNIQUE" UNIQUE (uuid);


--
-- Name: attribute ATTRIBUTE_CODE_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attribute
    ADD CONSTRAINT "ATTRIBUTE_CODE_UNIQUE" UNIQUE (attribute_code);


--
-- Name: attribute ATTRIBUTE_CODE_UUID_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attribute
    ADD CONSTRAINT "ATTRIBUTE_CODE_UUID_UNIQUE" UNIQUE (uuid);


--
-- Name: attribute_group_link ATTRIBUTE_GROUP_LINK_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attribute_group_link
    ADD CONSTRAINT "ATTRIBUTE_GROUP_LINK_UNIQUE" UNIQUE (attribute_id, group_id);


--
-- Name: attribute_group ATTRIBUTE_GROUP_UUID_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attribute_group
    ADD CONSTRAINT "ATTRIBUTE_GROUP_UUID_UNIQUE" UNIQUE (uuid);


--
-- Name: attribute_option ATTRIBUTE_OPTION_UUID_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attribute_option
    ADD CONSTRAINT "ATTRIBUTE_OPTION_UUID_UNIQUE" UNIQUE (uuid);


--
-- Name: cart_address CART_ADDRESS_UUID_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_address
    ADD CONSTRAINT "CART_ADDRESS_UUID_UNIQUE" UNIQUE (uuid);


--
-- Name: cart_item CART_ITEM_UUID_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_item
    ADD CONSTRAINT "CART_ITEM_UUID_UNIQUE" UNIQUE (uuid);


--
-- Name: cart CART_UUID_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT "CART_UUID_UNIQUE" UNIQUE (uuid);


--
-- Name: category_description CATEGORY_ID_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category_description
    ADD CONSTRAINT "CATEGORY_ID_UNIQUE" UNIQUE (category_description_category_id);


--
-- Name: category_description CATEGORY_URL_KEY_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category_description
    ADD CONSTRAINT "CATEGORY_URL_KEY_UNIQUE" UNIQUE (url_key);


--
-- Name: category CATEGORY_UUID_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT "CATEGORY_UUID_UNIQUE" UNIQUE (uuid);


--
-- Name: cms_page CMS_PAGE_UUID; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cms_page
    ADD CONSTRAINT "CMS_PAGE_UUID" UNIQUE (uuid);


--
-- Name: collection COLLECTION_CODE_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collection
    ADD CONSTRAINT "COLLECTION_CODE_UNIQUE" UNIQUE (code);


--
-- Name: collection COLLECTION_UUID_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collection
    ADD CONSTRAINT "COLLECTION_UUID_UNIQUE" UNIQUE (uuid);


--
-- Name: coupon COUPON_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coupon
    ADD CONSTRAINT "COUPON_UNIQUE" UNIQUE (coupon);


--
-- Name: coupon COUPON_UUID_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coupon
    ADD CONSTRAINT "COUPON_UUID_UNIQUE" UNIQUE (uuid);


--
-- Name: customer_address CUSTOMER_ADDRESS_UUID_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_address
    ADD CONSTRAINT "CUSTOMER_ADDRESS_UUID_UNIQUE" UNIQUE (uuid);


--
-- Name: customer CUSTOMER_UUID_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT "CUSTOMER_UUID_UNIQUE" UNIQUE (uuid);


--
-- Name: customer EMAIL_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT "EMAIL_UNIQUE" UNIQUE (email);


--
-- Name: event EVENT_UUID; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT "EVENT_UUID" UNIQUE (uuid);


--
-- Name: shipping_zone_method METHOD_ZONE_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_zone_method
    ADD CONSTRAINT "METHOD_ZONE_UNIQUE" UNIQUE (zone_id, method_id);


--
-- Name: migration MODULE_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration
    ADD CONSTRAINT "MODULE_UNIQUE" UNIQUE (module);


--
-- Name: product_attribute_value_index OPTION_VALUE_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_attribute_value_index
    ADD CONSTRAINT "OPTION_VALUE_UNIQUE" UNIQUE (product_id, attribute_id, option_id);


--
-- Name: order_activity ORDER_ACTIVITY_UUID_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_activity
    ADD CONSTRAINT "ORDER_ACTIVITY_UUID_UNIQUE" UNIQUE (uuid);


--
-- Name: order_address ORDER_ADDRESS_UUID_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_address
    ADD CONSTRAINT "ORDER_ADDRESS_UUID_UNIQUE" UNIQUE (uuid);


--
-- Name: order_item ORDER_ITEM_UUID_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT "ORDER_ITEM_UUID_UNIQUE" UNIQUE (uuid);


--
-- Name: order ORDER_NUMBER_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "ORDER_NUMBER_UNIQUE" UNIQUE (order_number);


--
-- Name: order ORDER_UUID_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "ORDER_UUID_UNIQUE" UNIQUE (uuid);


--
-- Name: cms_page_description PAGE_ID_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cms_page_description
    ADD CONSTRAINT "PAGE_ID_UNIQUE" UNIQUE (cms_page_description_cms_page_id);


--
-- Name: payment_transaction PAYMENT_TRANSACTION_UUID_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_transaction
    ADD CONSTRAINT "PAYMENT_TRANSACTION_UUID_UNIQUE" UNIQUE (uuid);


--
-- Name: product_collection PRODUCT_COLLECTION_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_collection
    ADD CONSTRAINT "PRODUCT_COLLECTION_UNIQUE" UNIQUE (collection_id, product_id);


--
-- Name: product_custom_option PRODUCT_CUSTOM_OPTION_UUID_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_custom_option
    ADD CONSTRAINT "PRODUCT_CUSTOM_OPTION_UUID_UNIQUE" UNIQUE (uuid);


--
-- Name: product_custom_option_value PRODUCT_CUSTOM_OPTION_VALUE_UUID_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_custom_option_value
    ADD CONSTRAINT "PRODUCT_CUSTOM_OPTION_VALUE_UUID_UNIQUE" UNIQUE (uuid);


--
-- Name: product_description PRODUCT_ID_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_description
    ADD CONSTRAINT "PRODUCT_ID_UNIQUE" UNIQUE (product_description_product_id);


--
-- Name: product_inventory PRODUCT_INVENTORY_PRODUCT_ID_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_inventory
    ADD CONSTRAINT "PRODUCT_INVENTORY_PRODUCT_ID_UNIQUE" UNIQUE (product_inventory_product_id);


--
-- Name: product PRODUCT_SKU_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT "PRODUCT_SKU_UNIQUE" UNIQUE (sku);


--
-- Name: product_description PRODUCT_URL_KEY_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_description
    ADD CONSTRAINT "PRODUCT_URL_KEY_UNIQUE" UNIQUE (url_key);


--
-- Name: product PRODUCT_UUID_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT "PRODUCT_UUID_UNIQUE" UNIQUE (uuid);


--
-- Name: session SESSION_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT "SESSION_PKEY" PRIMARY KEY (sid);


--
-- Name: setting SETTING_NAME_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.setting
    ADD CONSTRAINT "SETTING_NAME_UNIQUE" UNIQUE (name);


--
-- Name: setting SETTING_UUID_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.setting
    ADD CONSTRAINT "SETTING_UUID_UNIQUE" UNIQUE (uuid);


--
-- Name: shipment SHIPMENT_UUID_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment
    ADD CONSTRAINT "SHIPMENT_UUID_UNIQUE" UNIQUE (uuid);


--
-- Name: shipping_method SHIPPING_METHOD_NAME_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_method
    ADD CONSTRAINT "SHIPPING_METHOD_NAME_UNIQUE" UNIQUE (name);


--
-- Name: shipping_method SHIPPING_METHOD_UUID_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_method
    ADD CONSTRAINT "SHIPPING_METHOD_UUID_UNIQUE" UNIQUE (uuid);


--
-- Name: shipping_zone_province SHIPPING_ZONE_PROVINCE_PROVINCE_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_zone_province
    ADD CONSTRAINT "SHIPPING_ZONE_PROVINCE_PROVINCE_UNIQUE" UNIQUE (province);


--
-- Name: shipping_zone_province SHIPPING_ZONE_PROVINCE_UUID_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_zone_province
    ADD CONSTRAINT "SHIPPING_ZONE_PROVINCE_UUID_UNIQUE" UNIQUE (uuid);


--
-- Name: shipping_zone SHIPPING_ZONE_UUID_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_zone
    ADD CONSTRAINT "SHIPPING_ZONE_UUID_UNIQUE" UNIQUE (uuid);


--
-- Name: tax_class TAX_CLASS_UUID_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_class
    ADD CONSTRAINT "TAX_CLASS_UUID_UNIQUE" UNIQUE (uuid);


--
-- Name: tax_rate TAX_RATE_PRIORITY_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_rate
    ADD CONSTRAINT "TAX_RATE_PRIORITY_UNIQUE" UNIQUE (priority, tax_class_id);


--
-- Name: tax_rate TAX_RATE_UUID_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_rate
    ADD CONSTRAINT "TAX_RATE_UUID_UNIQUE" UNIQUE (uuid);


--
-- Name: payment_transaction UNQ_PAYMENT_TRANSACTION_ID_ORDER_ID; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_transaction
    ADD CONSTRAINT "UNQ_PAYMENT_TRANSACTION_ID_ORDER_ID" UNIQUE (payment_transaction_order_id, transaction_id);


--
-- Name: cms_page_description URL_KEY_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cms_page_description
    ADD CONSTRAINT "URL_KEY_UNIQUE" UNIQUE (url_key);


--
-- Name: url_rewrite URL_REWRITE_PATH_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.url_rewrite
    ADD CONSTRAINT "URL_REWRITE_PATH_UNIQUE" UNIQUE (language, entity_uuid);


--
-- Name: variant_group VARIANT_GROUP_UUID_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variant_group
    ADD CONSTRAINT "VARIANT_GROUP_UUID_UNIQUE" UNIQUE (uuid);


--
-- Name: admin_user admin_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_user
    ADD CONSTRAINT admin_user_pkey PRIMARY KEY (admin_user_id);


--
-- Name: attribute_group_link attribute_group_link_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attribute_group_link
    ADD CONSTRAINT attribute_group_link_pkey PRIMARY KEY (attribute_group_link_id);


--
-- Name: attribute_group attribute_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attribute_group
    ADD CONSTRAINT attribute_group_pkey PRIMARY KEY (attribute_group_id);


--
-- Name: attribute_option attribute_option_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attribute_option
    ADD CONSTRAINT attribute_option_pkey PRIMARY KEY (attribute_option_id);


--
-- Name: attribute attribute_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attribute
    ADD CONSTRAINT attribute_pkey PRIMARY KEY (attribute_id);


--
-- Name: cart_address cart_address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_address
    ADD CONSTRAINT cart_address_pkey PRIMARY KEY (cart_address_id);


--
-- Name: cart_item cart_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_item
    ADD CONSTRAINT cart_item_pkey PRIMARY KEY (cart_item_id);


--
-- Name: cart cart_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_pkey PRIMARY KEY (cart_id);


--
-- Name: category_description category_description_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category_description
    ADD CONSTRAINT category_description_pkey PRIMARY KEY (category_description_id);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (category_id);


--
-- Name: cms_page_description cms_page_description_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cms_page_description
    ADD CONSTRAINT cms_page_description_pkey PRIMARY KEY (cms_page_description_id);


--
-- Name: cms_page cms_page_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cms_page
    ADD CONSTRAINT cms_page_pkey PRIMARY KEY (cms_page_id);


--
-- Name: collection collection_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collection
    ADD CONSTRAINT collection_pkey PRIMARY KEY (collection_id);


--
-- Name: coupon coupon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coupon
    ADD CONSTRAINT coupon_pkey PRIMARY KEY (coupon_id);


--
-- Name: customer_address customer_address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_address
    ADD CONSTRAINT customer_address_pkey PRIMARY KEY (customer_address_id);


--
-- Name: customer_group customer_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_group
    ADD CONSTRAINT customer_group_pkey PRIMARY KEY (customer_group_id);


--
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);


--
-- Name: event event_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_pkey PRIMARY KEY (event_id);


--
-- Name: migration migration_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration
    ADD CONSTRAINT migration_pkey PRIMARY KEY (migration_id);


--
-- Name: order_activity order_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_activity
    ADD CONSTRAINT order_activity_pkey PRIMARY KEY (order_activity_id);


--
-- Name: order_address order_address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_address
    ADD CONSTRAINT order_address_pkey PRIMARY KEY (order_address_id);


--
-- Name: order_item order_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT order_item_pkey PRIMARY KEY (order_item_id);


--
-- Name: order order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY (order_id);


--
-- Name: payment_transaction payment_transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_transaction
    ADD CONSTRAINT payment_transaction_pkey PRIMARY KEY (payment_transaction_id);


--
-- Name: product_attribute_value_index product_attribute_value_index_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_attribute_value_index
    ADD CONSTRAINT product_attribute_value_index_pkey PRIMARY KEY (product_attribute_value_index_id);


--
-- Name: product_collection product_collection_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_collection
    ADD CONSTRAINT product_collection_pkey PRIMARY KEY (product_collection_id);


--
-- Name: product_custom_option product_custom_option_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_custom_option
    ADD CONSTRAINT product_custom_option_pkey PRIMARY KEY (product_custom_option_id);


--
-- Name: product_custom_option_value product_custom_option_value_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_custom_option_value
    ADD CONSTRAINT product_custom_option_value_pkey PRIMARY KEY (product_custom_option_value_id);


--
-- Name: product_description product_description_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_description
    ADD CONSTRAINT product_description_pkey PRIMARY KEY (product_description_id);


--
-- Name: product_image product_image_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_image
    ADD CONSTRAINT product_image_pkey PRIMARY KEY (product_image_id);


--
-- Name: product_inventory product_inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_inventory
    ADD CONSTRAINT product_inventory_pkey PRIMARY KEY (product_inventory_id);


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (product_id);


--
-- Name: reset_password_token reset_password_token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reset_password_token
    ADD CONSTRAINT reset_password_token_pkey PRIMARY KEY (reset_password_token_id);


--
-- Name: setting setting_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.setting
    ADD CONSTRAINT setting_pkey PRIMARY KEY (setting_id);


--
-- Name: shipment shipment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment
    ADD CONSTRAINT shipment_pkey PRIMARY KEY (shipment_id);


--
-- Name: shipping_method shipping_method_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_method
    ADD CONSTRAINT shipping_method_pkey PRIMARY KEY (shipping_method_id);


--
-- Name: shipping_zone_method shipping_zone_method_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_zone_method
    ADD CONSTRAINT shipping_zone_method_pkey PRIMARY KEY (shipping_zone_method_id);


--
-- Name: shipping_zone shipping_zone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_zone
    ADD CONSTRAINT shipping_zone_pkey PRIMARY KEY (shipping_zone_id);


--
-- Name: shipping_zone_province shipping_zone_province_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_zone_province
    ADD CONSTRAINT shipping_zone_province_pkey PRIMARY KEY (shipping_zone_province_id);


--
-- Name: tax_class tax_class_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_class
    ADD CONSTRAINT tax_class_pkey PRIMARY KEY (tax_class_id);


--
-- Name: tax_rate tax_rate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_rate
    ADD CONSTRAINT tax_rate_pkey PRIMARY KEY (tax_rate_id);


--
-- Name: url_rewrite url_rewrite_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.url_rewrite
    ADD CONSTRAINT url_rewrite_pkey PRIMARY KEY (url_rewrite_id);


--
-- Name: variant_group variant_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variant_group
    ADD CONSTRAINT variant_group_pkey PRIMARY KEY (variant_group_id);


--
-- Name: FK_ATTRIBUTE_GROUP_VARIANT; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_ATTRIBUTE_GROUP_VARIANT" ON public.variant_group USING btree (attribute_group_id);


--
-- Name: FK_ATTRIBUTE_LINK; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_ATTRIBUTE_LINK" ON public.attribute_group_link USING btree (attribute_id);


--
-- Name: FK_ATTRIBUTE_OPTION; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_ATTRIBUTE_OPTION" ON public.attribute_option USING btree (attribute_id);


--
-- Name: FK_ATTRIBUTE_OPTION_VALUE_LINK; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_ATTRIBUTE_OPTION_VALUE_LINK" ON public.product_attribute_value_index USING btree (option_id);


--
-- Name: FK_ATTRIBUTE_VALUE_LINK; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_ATTRIBUTE_VALUE_LINK" ON public.product_attribute_value_index USING btree (attribute_id);


--
-- Name: FK_ATTRIBUTE_VARIANT_FIVE; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_ATTRIBUTE_VARIANT_FIVE" ON public.variant_group USING btree (attribute_five);


--
-- Name: FK_ATTRIBUTE_VARIANT_FOUR; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_ATTRIBUTE_VARIANT_FOUR" ON public.variant_group USING btree (attribute_four);


--
-- Name: FK_ATTRIBUTE_VARIANT_ONE; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_ATTRIBUTE_VARIANT_ONE" ON public.variant_group USING btree (attribute_one);


--
-- Name: FK_ATTRIBUTE_VARIANT_THREE; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_ATTRIBUTE_VARIANT_THREE" ON public.variant_group USING btree (attribute_three);


--
-- Name: FK_ATTRIBUTE_VARIANT_TWO; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_ATTRIBUTE_VARIANT_TWO" ON public.variant_group USING btree (attribute_two);


--
-- Name: FK_CART_ITEM; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_CART_ITEM" ON public.cart_item USING btree (cart_id);


--
-- Name: FK_CART_ITEM_PRODUCT; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_CART_ITEM_PRODUCT" ON public.cart_item USING btree (product_id);


--
-- Name: FK_CART_SHIPPING_ZONE; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_CART_SHIPPING_ZONE" ON public.cart USING btree (shipping_zone_id);


--
-- Name: FK_CATEGORY_DESCRIPTION; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_CATEGORY_DESCRIPTION" ON public.category_description USING btree (category_description_category_id);


--
-- Name: FK_CMS_PAGE_DESCRIPTION; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_CMS_PAGE_DESCRIPTION" ON public.cms_page_description USING btree (cms_page_description_cms_page_id);


--
-- Name: FK_COLLECTION_PRODUCT_LINK; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_COLLECTION_PRODUCT_LINK" ON public.product_collection USING btree (collection_id);


--
-- Name: FK_CUSTOMER_ADDRESS; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_CUSTOMER_ADDRESS" ON public.customer_address USING btree (customer_id);


--
-- Name: FK_CUSTOMER_GROUP; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_CUSTOMER_GROUP" ON public.customer USING btree (group_id);


--
-- Name: FK_CUSTOM_OPTION_VALUE; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_CUSTOM_OPTION_VALUE" ON public.product_custom_option_value USING btree (option_id);


--
-- Name: FK_GROUP_LINK; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_GROUP_LINK" ON public.attribute_group_link USING btree (group_id);


--
-- Name: FK_METHOD_ZONE; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_METHOD_ZONE" ON public.shipping_zone_method USING btree (method_id);


--
-- Name: FK_ORDER; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_ORDER" ON public.order_item USING btree (order_item_order_id);


--
-- Name: FK_ORDER_ACTIVITY; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_ORDER_ACTIVITY" ON public.order_activity USING btree (order_activity_order_id);


--
-- Name: FK_ORDER_SHIPMENT; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_ORDER_SHIPMENT" ON public.shipment USING btree (shipment_order_id);


--
-- Name: FK_PAYMENT_TRANSACTION_ORDER; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_PAYMENT_TRANSACTION_ORDER" ON public.payment_transaction USING btree (payment_transaction_order_id);


--
-- Name: FK_PRODUCT_ATTRIBUTE_GROUP; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_PRODUCT_ATTRIBUTE_GROUP" ON public.product USING btree (group_id);


--
-- Name: FK_PRODUCT_ATTRIBUTE_LINK; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_PRODUCT_ATTRIBUTE_LINK" ON public.product_attribute_value_index USING btree (product_id);


--
-- Name: FK_PRODUCT_COLLECTION_LINK; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_PRODUCT_COLLECTION_LINK" ON public.product_collection USING btree (product_id);


--
-- Name: FK_PRODUCT_CUSTOM_OPTION; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_PRODUCT_CUSTOM_OPTION" ON public.product_custom_option USING btree (product_custom_option_product_id);


--
-- Name: FK_PRODUCT_DESCRIPTION; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_PRODUCT_DESCRIPTION" ON public.product_description USING btree (product_description_product_id);


--
-- Name: FK_PRODUCT_IMAGE_LINK; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_PRODUCT_IMAGE_LINK" ON public.product_image USING btree (product_image_product_id);


--
-- Name: FK_PRODUCT_VARIANT_GROUP; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_PRODUCT_VARIANT_GROUP" ON public.product USING btree (variant_group_id);


--
-- Name: FK_SHIPPING_ZONE_PROVINCE; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_SHIPPING_ZONE_PROVINCE" ON public.shipping_zone_province USING btree (zone_id);


--
-- Name: FK_ZONE_METHOD; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FK_ZONE_METHOD" ON public.shipping_zone_method USING btree (zone_id);


--
-- Name: IDX_SESSION_EXPIRE; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_SESSION_EXPIRE" ON public.session USING btree (expire);


--
-- Name: PRODUCT_SEARCH_INDEX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "PRODUCT_SEARCH_INDEX" ON public.product_description USING gin (to_tsvector('simple'::regconfig, (((name)::text || ' '::text) || description)));


--
-- Name: category ADD_CATEGORY_CREATED_EVENT_TRIGGER; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "ADD_CATEGORY_CREATED_EVENT_TRIGGER" AFTER INSERT ON public.category FOR EACH ROW EXECUTE FUNCTION public.add_category_created_event();


--
-- Name: category ADD_CATEGORY_DELETED_EVENT_TRIGGER; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "ADD_CATEGORY_DELETED_EVENT_TRIGGER" AFTER DELETE ON public.category FOR EACH ROW EXECUTE FUNCTION public.add_category_deleted_event();


--
-- Name: category ADD_CATEGORY_UPDATED_EVENT_TRIGGER; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "ADD_CATEGORY_UPDATED_EVENT_TRIGGER" AFTER UPDATE ON public.category FOR EACH ROW EXECUTE FUNCTION public.add_category_updated_event();


--
-- Name: customer ADD_CUSTOMER_CREATED_EVENT_TRIGGER; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "ADD_CUSTOMER_CREATED_EVENT_TRIGGER" AFTER INSERT ON public.customer FOR EACH ROW EXECUTE FUNCTION public.add_customer_created_event();


--
-- Name: customer ADD_CUSTOMER_DELETED_EVENT_TRIGGER; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "ADD_CUSTOMER_DELETED_EVENT_TRIGGER" AFTER DELETE ON public.customer FOR EACH ROW EXECUTE FUNCTION public.add_customer_deleted_event();


--
-- Name: customer ADD_CUSTOMER_UPDATED_EVENT_TRIGGER; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "ADD_CUSTOMER_UPDATED_EVENT_TRIGGER" AFTER UPDATE ON public.customer FOR EACH ROW EXECUTE FUNCTION public.add_customer_updated_event();


--
-- Name: product_inventory ADD_INVENTORY_UPDATED_EVENT_TRIGGER; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "ADD_INVENTORY_UPDATED_EVENT_TRIGGER" AFTER UPDATE ON public.product_inventory FOR EACH ROW EXECUTE FUNCTION public.add_product_inventory_updated_event();


--
-- Name: order ADD_ORDER_CREATED_EVENT_TRIGGER; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "ADD_ORDER_CREATED_EVENT_TRIGGER" AFTER INSERT ON public."order" FOR EACH ROW EXECUTE FUNCTION public.add_order_created_event();


--
-- Name: product ADD_PRODUCT_CREATED_EVENT_TRIGGER; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "ADD_PRODUCT_CREATED_EVENT_TRIGGER" AFTER INSERT ON public.product FOR EACH ROW EXECUTE FUNCTION public.add_product_created_event();


--
-- Name: product ADD_PRODUCT_DELETED_EVENT_TRIGGER; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "ADD_PRODUCT_DELETED_EVENT_TRIGGER" AFTER DELETE ON public.product FOR EACH ROW EXECUTE FUNCTION public.add_product_deleted_event();


--
-- Name: product ADD_PRODUCT_UPDATED_EVENT_TRIGGER; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "ADD_PRODUCT_UPDATED_EVENT_TRIGGER" AFTER UPDATE ON public.product FOR EACH ROW EXECUTE FUNCTION public.add_product_updated_event();


--
-- Name: category_description BUILD_CATEGORY_URL_KEY_TRIGGER; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "BUILD_CATEGORY_URL_KEY_TRIGGER" BEFORE INSERT OR UPDATE ON public.category_description FOR EACH ROW EXECUTE FUNCTION public.build_url_key();


--
-- Name: product_description BUILD_PRODUCT_URL_KEY_TRIGGER; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "BUILD_PRODUCT_URL_KEY_TRIGGER" BEFORE INSERT OR UPDATE ON public.product_description FOR EACH ROW EXECUTE FUNCTION public.build_url_key();


--
-- Name: category DELETE_SUB_CATEGORIES_TRIGGER; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "DELETE_SUB_CATEGORIES_TRIGGER" AFTER DELETE ON public.category FOR EACH ROW EXECUTE FUNCTION public.delete_sub_categories();


--
-- Name: product PREVENT_CHANGING_ATTRIBUTE_GROUP_OF_PRODUCT_WITH_VARIANTS; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "PREVENT_CHANGING_ATTRIBUTE_GROUP_OF_PRODUCT_WITH_VARIANTS" BEFORE UPDATE ON public.product FOR EACH ROW EXECUTE FUNCTION public.prevent_change_attribute_group();


--
-- Name: attribute_group PREVENT_DELETING_THE_DEFAULT_ATTRIBUTE_GROUP; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "PREVENT_DELETING_THE_DEFAULT_ATTRIBUTE_GROUP" BEFORE DELETE ON public.attribute_group FOR EACH ROW EXECUTE FUNCTION public.prevent_delete_default_attribute_group();


--
-- Name: customer_group PREVENT_DELETING_THE_DEFAULT_CUSTOMER_GROUP; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "PREVENT_DELETING_THE_DEFAULT_CUSTOMER_GROUP" BEFORE DELETE ON public.customer_group FOR EACH ROW EXECUTE FUNCTION public.prevent_delete_default_customer_group();


--
-- Name: tax_class PREVENT_DELETING_THE_DEFAULT_TAX_CLASS; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "PREVENT_DELETING_THE_DEFAULT_TAX_CLASS" BEFORE DELETE ON public.tax_class FOR EACH ROW EXECUTE FUNCTION public.prevent_delete_default_tax_class();


--
-- Name: product_image PRODUCT_IMAGE_ADDED; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "PRODUCT_IMAGE_ADDED" AFTER INSERT ON public.product_image FOR EACH ROW EXECUTE FUNCTION public.product_image_insert_trigger();


--
-- Name: customer SET_DEFAULT_CUSTOMER_GROUP; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "SET_DEFAULT_CUSTOMER_GROUP" BEFORE INSERT ON public.customer FOR EACH ROW EXECUTE FUNCTION public.set_default_customer_group();


--
-- Name: attribute_option TRIGGER_AFTER_ATTRIBUTE_OPTION_UPDATE; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "TRIGGER_AFTER_ATTRIBUTE_OPTION_UPDATE" AFTER UPDATE ON public.attribute_option FOR EACH ROW EXECUTE FUNCTION public.update_product_attribute_option_value_text();


--
-- Name: attribute_option TRIGGER_AFTER_DELETE_ATTRIBUTE_OPTION; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "TRIGGER_AFTER_DELETE_ATTRIBUTE_OPTION" AFTER DELETE ON public.attribute_option FOR EACH ROW EXECUTE FUNCTION public.delete_product_attribute_value_index();


--
-- Name: order_item TRIGGER_AFTER_INSERT_ORDER_ITEM; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "TRIGGER_AFTER_INSERT_ORDER_ITEM" AFTER INSERT ON public.order_item FOR EACH ROW EXECUTE FUNCTION public.reduce_product_stock_when_order_placed();


--
-- Name: product TRIGGER_AFTER_INSERT_PRODUCT; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE CONSTRAINT TRIGGER "TRIGGER_AFTER_INSERT_PRODUCT" AFTER INSERT ON public.product DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION public.update_variant_group_visibility();


--
-- Name: attribute_group_link TRIGGER_AFTER_REMOVE_ATTRIBUTE_FROM_GROUP; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "TRIGGER_AFTER_REMOVE_ATTRIBUTE_FROM_GROUP" AFTER DELETE ON public.attribute_group_link FOR EACH ROW EXECUTE FUNCTION public.remove_attribute_from_group();


--
-- Name: attribute TRIGGER_AFTER_UPDATE_ATTRIBUTE; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "TRIGGER_AFTER_UPDATE_ATTRIBUTE" AFTER UPDATE ON public.attribute FOR EACH ROW EXECUTE FUNCTION public.delete_variant_group_after_attribute_type_changed();


--
-- Name: product TRIGGER_PRODUCT_AFTER_UPDATE; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE CONSTRAINT TRIGGER "TRIGGER_PRODUCT_AFTER_UPDATE" AFTER UPDATE ON public.product DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE FUNCTION public.update_attribute_index_and_variant_group_visibility();


--
-- Name: order TRIGGER_UPDATE_COUPON_USED_TIME_AFTER_CREATE_ORDER; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "TRIGGER_UPDATE_COUPON_USED_TIME_AFTER_CREATE_ORDER" AFTER INSERT ON public."order" FOR EACH ROW EXECUTE FUNCTION public.set_coupon_used_time();


--
-- Name: variant_group FK_ATTRIBUTE_GROUP_VARIANT; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variant_group
    ADD CONSTRAINT "FK_ATTRIBUTE_GROUP_VARIANT" FOREIGN KEY (attribute_group_id) REFERENCES public.attribute_group(attribute_group_id) ON DELETE CASCADE;


--
-- Name: attribute_group_link FK_ATTRIBUTE_LINK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attribute_group_link
    ADD CONSTRAINT "FK_ATTRIBUTE_LINK" FOREIGN KEY (attribute_id) REFERENCES public.attribute(attribute_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: attribute_option FK_ATTRIBUTE_OPTION; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attribute_option
    ADD CONSTRAINT "FK_ATTRIBUTE_OPTION" FOREIGN KEY (attribute_id) REFERENCES public.attribute(attribute_id) ON DELETE CASCADE;


--
-- Name: product_attribute_value_index FK_ATTRIBUTE_OPTION_VALUE_LINK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_attribute_value_index
    ADD CONSTRAINT "FK_ATTRIBUTE_OPTION_VALUE_LINK" FOREIGN KEY (option_id) REFERENCES public.attribute_option(attribute_option_id) ON DELETE CASCADE;


--
-- Name: product_attribute_value_index FK_ATTRIBUTE_VALUE_LINK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_attribute_value_index
    ADD CONSTRAINT "FK_ATTRIBUTE_VALUE_LINK" FOREIGN KEY (attribute_id) REFERENCES public.attribute(attribute_id) ON DELETE CASCADE;


--
-- Name: variant_group FK_ATTRIBUTE_VARIANT_FIVE; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variant_group
    ADD CONSTRAINT "FK_ATTRIBUTE_VARIANT_FIVE" FOREIGN KEY (attribute_five) REFERENCES public.attribute(attribute_id) ON DELETE CASCADE;


--
-- Name: variant_group FK_ATTRIBUTE_VARIANT_FOUR; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variant_group
    ADD CONSTRAINT "FK_ATTRIBUTE_VARIANT_FOUR" FOREIGN KEY (attribute_four) REFERENCES public.attribute(attribute_id) ON DELETE CASCADE;


--
-- Name: variant_group FK_ATTRIBUTE_VARIANT_ONE; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variant_group
    ADD CONSTRAINT "FK_ATTRIBUTE_VARIANT_ONE" FOREIGN KEY (attribute_one) REFERENCES public.attribute(attribute_id) ON DELETE CASCADE;


--
-- Name: variant_group FK_ATTRIBUTE_VARIANT_THREE; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variant_group
    ADD CONSTRAINT "FK_ATTRIBUTE_VARIANT_THREE" FOREIGN KEY (attribute_three) REFERENCES public.attribute(attribute_id) ON DELETE CASCADE;


--
-- Name: variant_group FK_ATTRIBUTE_VARIANT_TWO; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variant_group
    ADD CONSTRAINT "FK_ATTRIBUTE_VARIANT_TWO" FOREIGN KEY (attribute_two) REFERENCES public.attribute(attribute_id) ON DELETE CASCADE;


--
-- Name: cart_item FK_CART_ITEM; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_item
    ADD CONSTRAINT "FK_CART_ITEM" FOREIGN KEY (cart_id) REFERENCES public.cart(cart_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cart_item FK_CART_ITEM_PRODUCT; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_item
    ADD CONSTRAINT "FK_CART_ITEM_PRODUCT" FOREIGN KEY (product_id) REFERENCES public.product(product_id) ON DELETE CASCADE;


--
-- Name: cart FK_CART_SHIPPING_ZONE; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT "FK_CART_SHIPPING_ZONE" FOREIGN KEY (shipping_zone_id) REFERENCES public.shipping_zone(shipping_zone_id) ON DELETE SET NULL;


--
-- Name: category_description FK_CATEGORY_DESCRIPTION; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category_description
    ADD CONSTRAINT "FK_CATEGORY_DESCRIPTION" FOREIGN KEY (category_description_category_id) REFERENCES public.category(category_id) ON DELETE CASCADE;


--
-- Name: cms_page_description FK_CMS_PAGE_DESCRIPTION; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cms_page_description
    ADD CONSTRAINT "FK_CMS_PAGE_DESCRIPTION" FOREIGN KEY (cms_page_description_cms_page_id) REFERENCES public.cms_page(cms_page_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_collection FK_COLLECTION_PRODUCT_LINK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_collection
    ADD CONSTRAINT "FK_COLLECTION_PRODUCT_LINK" FOREIGN KEY (collection_id) REFERENCES public.collection(collection_id) ON DELETE CASCADE;


--
-- Name: customer_address FK_CUSTOMER_ADDRESS; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_address
    ADD CONSTRAINT "FK_CUSTOMER_ADDRESS" FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id) ON DELETE CASCADE;


--
-- Name: customer FK_CUSTOMER_GROUP; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT "FK_CUSTOMER_GROUP" FOREIGN KEY (group_id) REFERENCES public.customer_group(customer_group_id) ON DELETE SET NULL;


--
-- Name: product_custom_option_value FK_CUSTOM_OPTION_VALUE; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_custom_option_value
    ADD CONSTRAINT "FK_CUSTOM_OPTION_VALUE" FOREIGN KEY (option_id) REFERENCES public.product_custom_option(product_custom_option_id) ON DELETE CASCADE;


--
-- Name: attribute_group_link FK_GROUP_LINK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attribute_group_link
    ADD CONSTRAINT "FK_GROUP_LINK" FOREIGN KEY (group_id) REFERENCES public.attribute_group(attribute_group_id) ON DELETE CASCADE;


--
-- Name: shipping_zone_method FK_METHOD_ZONE; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_zone_method
    ADD CONSTRAINT "FK_METHOD_ZONE" FOREIGN KEY (method_id) REFERENCES public.shipping_method(shipping_method_id) ON DELETE CASCADE;


--
-- Name: order_item FK_ORDER; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT "FK_ORDER" FOREIGN KEY (order_item_order_id) REFERENCES public."order"(order_id) ON DELETE CASCADE;


--
-- Name: order_activity FK_ORDER_ACTIVITY; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_activity
    ADD CONSTRAINT "FK_ORDER_ACTIVITY" FOREIGN KEY (order_activity_order_id) REFERENCES public."order"(order_id) ON DELETE CASCADE;


--
-- Name: shipment FK_ORDER_SHIPMENT; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment
    ADD CONSTRAINT "FK_ORDER_SHIPMENT" FOREIGN KEY (shipment_order_id) REFERENCES public."order"(order_id) ON DELETE CASCADE;


--
-- Name: payment_transaction FK_PAYMENT_TRANSACTION_ORDER; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_transaction
    ADD CONSTRAINT "FK_PAYMENT_TRANSACTION_ORDER" FOREIGN KEY (payment_transaction_order_id) REFERENCES public."order"(order_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product FK_PRODUCT_ATTRIBUTE_GROUP; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT "FK_PRODUCT_ATTRIBUTE_GROUP" FOREIGN KEY (group_id) REFERENCES public.attribute_group(attribute_group_id) ON DELETE SET NULL;


--
-- Name: product_attribute_value_index FK_PRODUCT_ATTRIBUTE_LINK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_attribute_value_index
    ADD CONSTRAINT "FK_PRODUCT_ATTRIBUTE_LINK" FOREIGN KEY (product_id) REFERENCES public.product(product_id) ON DELETE CASCADE;


--
-- Name: product_collection FK_PRODUCT_COLLECTION_LINK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_collection
    ADD CONSTRAINT "FK_PRODUCT_COLLECTION_LINK" FOREIGN KEY (product_id) REFERENCES public.product(product_id) ON DELETE CASCADE;


--
-- Name: product_custom_option FK_PRODUCT_CUSTOM_OPTION; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_custom_option
    ADD CONSTRAINT "FK_PRODUCT_CUSTOM_OPTION" FOREIGN KEY (product_custom_option_product_id) REFERENCES public.product(product_id) ON DELETE CASCADE;


--
-- Name: product_description FK_PRODUCT_DESCRIPTION; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_description
    ADD CONSTRAINT "FK_PRODUCT_DESCRIPTION" FOREIGN KEY (product_description_product_id) REFERENCES public.product(product_id) ON DELETE CASCADE;


--
-- Name: product_image FK_PRODUCT_IMAGE_LINK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_image
    ADD CONSTRAINT "FK_PRODUCT_IMAGE_LINK" FOREIGN KEY (product_image_product_id) REFERENCES public.product(product_id) ON DELETE CASCADE;


--
-- Name: product FK_PRODUCT_VARIANT_GROUP; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT "FK_PRODUCT_VARIANT_GROUP" FOREIGN KEY (variant_group_id) REFERENCES public.variant_group(variant_group_id) ON DELETE SET NULL;


--
-- Name: reset_password_token FK_RESET_PASSWORD_TOKEN_CUSTOMER; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reset_password_token
    ADD CONSTRAINT "FK_RESET_PASSWORD_TOKEN_CUSTOMER" FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id) ON DELETE CASCADE;


--
-- Name: shipping_zone_province FK_SHIPPING_ZONE_PROVINCE; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_zone_province
    ADD CONSTRAINT "FK_SHIPPING_ZONE_PROVINCE" FOREIGN KEY (zone_id) REFERENCES public.shipping_zone(shipping_zone_id) ON DELETE CASCADE;


--
-- Name: product FK_TAX_CLASS; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT "FK_TAX_CLASS" FOREIGN KEY (tax_class) REFERENCES public.tax_class(tax_class_id) ON DELETE SET NULL;


--
-- Name: tax_rate FK_TAX_RATE_TAX_CLASS; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_rate
    ADD CONSTRAINT "FK_TAX_RATE_TAX_CLASS" FOREIGN KEY (tax_class_id) REFERENCES public.tax_class(tax_class_id) ON DELETE CASCADE;


--
-- Name: shipping_zone_method FK_ZONE_METHOD; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_zone_method
    ADD CONSTRAINT "FK_ZONE_METHOD" FOREIGN KEY (zone_id) REFERENCES public.shipping_zone(shipping_zone_id) ON DELETE CASCADE;


--
-- Name: product PRODUCT_CATEGORY_ID_CONSTRAINT; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT "PRODUCT_CATEGORY_ID_CONSTRAINT" FOREIGN KEY (category_id) REFERENCES public.category(category_id) ON DELETE SET NULL;


--
-- Name: product_inventory PRODUCT_INVENTORY_PRODUCT_ID_CONSTANTSRAINT; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_inventory
    ADD CONSTRAINT "PRODUCT_INVENTORY_PRODUCT_ID_CONSTANTSRAINT" FOREIGN KEY (product_inventory_product_id) REFERENCES public.product(product_id) ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                