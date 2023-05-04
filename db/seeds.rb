# Attractions create

attraction = Attraction.create(title: 'Долина троянд', description: 'Долина Троянд — парк-пам\'ятка садово-паркового мистецтва
в Україні розміщений неподалік від центральної частини міста Черкаси, при вулиці
Гагаріна, на березі Кременчуцького водосховища, від якого відгороджений лісосмугою.
Поруч з парком розміщений меморіальний комплекс Пагорб Слави. У парку є декілька
фонтанів з міні-озерами, облаштовані алеї з лавочками та ліхтарями, а також
невеликий пляж на березі Дніпра. У 2012 році в парку збудований сонячний годинник
у вигляді журавля та дванадцяти металевих кованих стільців. «Долина Троянд»
традиційно використовується для святкування дня міста. Тут у липні 2019 року
відбувся уже ХІ етнічний фестиваль «Трипільські зорі».')

attraction.geolocations.create(locality: 'Черкаси', latitude: 49.450941, longitude: 32.065144, street: 'вул. Гагаріна')

attraction = Attraction.create(title: 'Блакитний палац', description: 'Блакитним палацом жителі Черкас називають
будівлю колишнього готелю «Слов\'янський», що побудований на замовлення одного з
найвідоміших у свій час підприємців Скорини за проектом архітектора Владислава
Городецького в кінці XIX століття. Місце розташування: на розі вул. Хрещатик —
О. Дашковича. Блакитний палац побудовано з елементами таких стилів, як класицизм
і модерн, а також має запозичення з будівель середньовічної близькосхідної
архітектури')

attraction.geolocations.create(locality: 'Черкаси', latitude: 49.445000, longitude: 32.063333, street: 'вул. Хрещатик',
                               suite: '229/20', zip_code: '18001')

attraction = Attraction.create(title: 'парк Софіївка', description: 'Численним відвідувачам дендропарк «Софіївка» відомий як
туристична перлина України, музей садово-паркового мистецтва, місце, де можна
поринути у казковий романтичний світ природи, краси і кохання… Національний
дендрологічний парк „Софіївка” – одне з найвидатніших творінь світового садово-
паркового мистецтва кінця ХVІІІ – першої половини ХІХ ст. Парк розкинувся на
площі майже 180 га на узбіччі старовинного міста Умань')

attraction.geolocations.create(locality: 'Умань', latitude: 48.763056, longitude: 30.222500, street: 'вул. Київська',
                               suite: '12а', zip_code: '20300')

attraction = Attraction.create(title: 'Буцький каньйон', description: 'каньйон в межах смт Буки Уманського району, на річці
Гірський Тікич. Утворений у протерозойських гранітах, вік яких оцінюється у 2
мільярди років. Каньйон починається за 800 м нижче від греблі колишньої Буцької
ГЕС. Неподалік від греблі розташований водоспад Вир. Каньйон являє собою
оригінальний скелястий берег з виступами сірого граніту, заввишки близько
30 метрів. Довжина каньйону бл. 2,5 км, ширина — 80 м. Площа, що підлягає
природоохоронним заходам — 80 га. Буцький каньйон — рекреаційна зона, також
каньйон пасує для скелелазіння, сплавів на байдарках')

attraction.geolocations.create(locality: 'Буки', latitude: 49.090060, longitude: 30.398530, street: 'вул. Туристична',
                               suite: '3', zip_code: '20114')

attraction = Attraction.create(title: 'заказник Білосніжний', description: 'ботанічний заказник місцевого значення в межах
Національного природного парку "Холодний Яр". Холодний Яр – сакральна місцина
українського нескорного духу, що має неабияке історичне та культурне значення,
проте передовсім – це реліктовий лісовий масив, невичерпне джерело інформації для
біологів та екологів, багате на рідкісних представників флори.
Одне з природних багатств Холодного Яру – величезний килим первоцвітів – поля квітучого підсніжника складчастого')

attraction.geolocations.create(locality: 'Холодний Яр', latitude: 49.160957, longitude: 32.245732)

# First partner create

user = User.create(name: 'partner', email: 'partner@test.com', password: 'Partner123!', role: 1)

# Accommodations create

accommodation = Accommodation.create(name: 'Hotel Selena Family Resort',
                                     description: 'Цей готель розташований у тихому місці поруч з Дніпром. Інфраструктура готелю налічує літню терасу і ресторан. Гостям пропонується оренда велосипедів, тенісні корти, SUP-борди, прогулянки по Дніпру, рибалка, а також лазні на дровах з виходом на річку, а також можливість користуватися різноманітними спортивними майданчиками',
                                     kind: 'hotel', phone: '0472545454', email: 'selena@sample.com',
                                     address_owner: 'Байди Вишневецького, 15 Черкаси 18001', reg_code: '41643586',
                                     person: 'Кононенко Іван Васильович', user_id: user.id)

accommodation.geolocations.create(locality: 'Черкаси', latitude: 49.504189, longitude: 31.962388, street: 'вул. Дахнівська',
                                  suite: '21', zip_code: '19622')

checkin_start_time = Time.parse('2:00 PM')
checkin_end_time = Time.parse('12:00 PM')
checkout_start_time = Time.parse('8:00 AM')
checkout_end_time = Time.parse('1:00 PM')

Facility.create(checkin_start: checkin_start_time,
                checkin_end: checkin_end_time,
                checkout_start: checkout_start_time,
                checkout_end: checkout_end_time,
                credit_card: true,
                free_parking: true,
                wi_fi: true,
                breakfast: true,
                pets: true,
                accommodation_id: accommodation.id)

room = Room.create(places: 2, bed: 'double', name: 'Стандартний двомісний номер', quantity: 6,
                   description: 'Стандартний двомісний номер зі спільною ванною кімнатою 16 кв. м Кондиціонер',
                   price_per_night: 1690, accommodation_id: accommodation.id)

Amenity.create(conditioner: true, tv: true, refrigerator: true, hair_dryer: true,
               room_id: room.id)

room = Room.create(places: 2, bed: 'double', name: 'Напівлюкс', quantity: 2,
                   description: 'Напівлюкс Ванна кімната в номері 32 кв. м Кондиціонер Вид на басейн',
                   price_per_night: 2690, accommodation_id: accommodation.id)

Amenity.create(conditioner: true, tv: true, refrigerator: true, hair_dryer: true,
               room_id: room.id)

room = Room.create(places: 2, bed: 'double', name: 'Покращений', quantity: 2,
                   description: 'Покращений двомісний номер  Ванна кімната в номері 32 кв. м Кондиціонер ',
                   price_per_night: 3290, accommodation_id: accommodation.id)

Amenity.create(conditioner: true, tv: true, refrigerator: true, hair_dryer: true,
               room_id: room.id)

room = Room.create(places: 1, bed: 'one', name: 'Покращений одномісний', quantity: 4,
                   description: 'Покращений одномісний номер  Ванна кімната в номері 23 кв. м Кондиціонер ',
                   price_per_night: 2790, accommodation_id: accommodation.id)

Amenity.create(conditioner: true, tv: true, refrigerator: true, hair_dryer: true,
               room_id: room.id)

room = Room.create(places: 2, bed: 'double', name: 'Покращений двомісний', quantity: 3,
                   description: 'Покращений двомісний номер  Ванна кімната в номері 23 кв. м Кондиціонер ',
                   price_per_night: 3290, accommodation_id: accommodation.id)

Amenity.create(conditioner: true, tv: true, refrigerator: true, hair_dryer: true,
               room_id: room.id)

room = Room.create(places: 2, bed: 'twin', name: 'Покращений двомісний', quantity: 4,
                   description: 'Покращений двомісний номер   Ванна кімната в номері 23 кв. м Вид Кондиціонер ',
                   price_per_night: 3290, accommodation_id: accommodation.id)

Amenity.create(conditioner: true, tv: true, refrigerator: true, hair_dryer: true,
               room_id: room.id)

room = Room.create(places: 2, bed: 'double', name: 'Бунгало', quantity: 5,
                   description: 'Бунгало 40 кв. м Вид на сад Кондиціонер ',
                   price_per_night: 3990, accommodation_id: accommodation.id)

Amenity.create(conditioner: true, tv: true, refrigerator: true, hair_dryer: true, nice_view: true, inclusive: true,
               room_id: room.id)

room = Room.create(places: 3, bed: 'double+one', name: 'Сімейний люкс', quantity: 5,
                   description: 'Сімейний люкс 40 кв. м Вид Кондиціонер ',
                   price_per_night: 4490, accommodation_id: accommodation.id)

Amenity.create(conditioner: true, tv: true, refrigerator: true, hair_dryer: true, nice_view: true, inclusive: true,
               room_id: room.id)

accommodation = Accommodation.create(name: 'Dragomir Apartments',
                                     description: 'Комплекс апартаментів "Драгомир" розташований в Черкасах. В комплексі гостям пропонують індивідуально мебльовані апартаменти та номери-студіо з кондиціонерами. Гостям надається безкоштовний Wi-Fi',
                                     kind: 'apartment', phone: '0472454545', email: 'dragomir@sample.com',
                                     address_owner: 'Митницька, 18 Черкаси 18015', reg_code: '21626547',
                                     person: 'Харченко Іван Опанасович', user_id: user.id)

accommodation.geolocations.create(locality: 'Черкаси', latitude: 49.437345, longitude: 32.069233, street: 'вул. Митницька',
                                  suite: '16', zip_code: '18015')

checkin_start_time = Time.parse('2:00 PM')
checkin_end_time = Time.parse('10:00 PM')
checkout_start_time = Time.parse('9:00 AM')
checkout_end_time = Time.parse('1:00 PM')

Facility.create(checkin_start: checkin_start_time,
                checkin_end: checkin_end_time,
                checkout_start: checkout_start_time,
                checkout_end: checkout_end_time,
                credit_card: true,
                wi_fi: true,
                accommodation_id: accommodation.id)

room = Room.create(places: 2, bed: 'double', name: 'Студіо', quantity: 1,
                   description: 'Апартаменти-студіо',
                   price_per_night: 700, accommodation_id: accommodation.id)

Amenity.create(conditioner: true, tv: true, refrigerator: true, hair_dryer: true, kettle: true, mv_owen: true,
               room_id: room.id)

room = Room.create(places: 2, bed: 'double', name: 'Покращений', quantity: 1,
                   description: 'Покращені апартаменти ',
                   price_per_night: 900, accommodation_id: accommodation.id)

Amenity.create(conditioner: true, tv: true, refrigerator: true, hair_dryer: true, kettle: true, mv_owen: true,
               room_id: room.id)

room = Room.create(places: 4, bed: 'double+double', name: 'Студіо', quantity: 1,
                   description: 'Апартаменти-студіо ',
                   price_per_night: 800, accommodation_id: accommodation.id)

Amenity.create(conditioner: true, tv: true, refrigerator: true, hair_dryer: true, kettle: true, mv_owen: true,
               room_id: room.id)

# Second partner create

user = User.create(name: 'partner2', email: 'partner2@test.com', password: 'Partner1234!', role: 1)

accommodation = Accommodation.create(name: 'Guest House',
                                     description: 'Guest house offers accommodation in Uman, 2.4 km from Singing fountains in Uman and 700 metres from Grave of Tsadik Nachman. The accommodation is 1.4 km from Sofiyivka Park, and guests benefit from private parking available on site and free WiFi.',
                                     kind: 'apartment', phone: '0472555555', email: 'uman_best@sample.com',
                                     address_owner: 'Київська, 22 Умань 20300', reg_code: '222333',
                                     person: 'Вареник Гриць Якович', user_id: user.id)

accommodation.geolocations.create(locality: 'Умань', latitude: 48.751585, longitude: 30.234364, street: 'вул. Комарницького',
                                  suite: '21', zip_code: '20300')

checkin_start_time = Time.parse('2:00 PM')
checkin_end_time = Time.parse('10:00 PM')
checkout_start_time = Time.parse('9:00 AM')
checkout_end_time = Time.parse('1:00 PM')

Facility.create(checkin_start: checkin_start_time,
                checkin_end: checkin_end_time,
                checkout_start: checkout_start_time,
                checkout_end: checkout_end_time,
                wi_fi: true,
                accommodation_id: accommodation.id)

room = Room.create(places: 9, bed: '4 twin + one', name: 'Guest House', quantity: 1,
                   description: '3-кімнатні апартаменти',
                   price_per_night: 1625, accommodation_id: accommodation.id)

Amenity.create(conditioner: true, tv: true, refrigerator: true, hair_dryer: true, kettle: true, mv_owen: true,
               room_id: room.id)

# Users create

User.create(name: 'tourist', email: 'tourist@test.com', password: 'User123!', role: 0)
User.create(name: 'admin', email: 'admin@test.com', password: 'Admin123!', role: 2)

# Tours create

user = User.create(name: 'partner3', email: 'partner3@test.com', password: 'Partner345!', role: 1)

tour = Tour.create(title: 'Таємниці Холодного Яру', description: 'Запрошуємо всіх до Холодного Яру - унікального МІСЦЯ СИЛИ - на батьківщину борців за волю України різних епох – Гетьмана України Богдана Хмельницького, керівника гайдамацького повстання 1768 року Максима Залізняка та отамана полку гайдамаків Холодного Яру Василя Чучупака.
Ви побуваєте у Медведівці, Івківцях, Мельниках, Мотронинському монастирі, у Головківці біля джерела "Живун" та хуторі Буда. Побуваєте в родинному селі Максима Залізняка Івківцях, підніметесь на Семидубову гору, де за однією з версій поховано Гетьмана України Богдана Хмельницького та огляните старовинний Одинцівський млин.',
                   address_owner: 'м.Черкаси, вул. Гагаріна 73', reg_code: '170888', person: 'Петренко Свирид Опанасович',
                   seats: 42, price_per_one: 300.00, time_start: DateTime.new(2023, 4, 15, 9), time_end: DateTime.new(2023, 4, 15, 19),
                   phone: '0472-383030', email: 'tour@tour.ck.ua', user_id: user.id)

place = Place.create(name: 'Черкаси',
                     body: '09:00 - виїзд з м. Черкаси',
                     tour_id: tour.id)

place.geolocations.create(locality: 'палац Дружби Народів', latitude: 49.437380, longitude: 32.072098)

place = Place.create(name: 'с.Івківці',
                     body: '10:30 - прибуття до с.Івківці. Фотографуємось біля Одинцівського млину. Проходимось еко-стежкою на Семидубову гору',
                     tour_id: tour.id)

place.geolocations.create(locality: 'Івківці', latitude: 49.135550, longitude: 32.376386)

place = Place.create(name: 'с.Мельники',
                     body: '12:00 - фотографуємось біля вежі у с.Мельники',
                     tour_id: tour.id)

place.geolocations.create(locality: 'Мельники', latitude: 49.153775, longitude: 32.304358)

place = Place.create(name: 'Мотронинський монастир',
                     body: '13:00 - прибуття до Гаймацького ставу. Огляд Мотронинського монастиря',
                     tour_id: tour.id)

place.geolocations.create(locality: 'Мотронинський монастир', latitude: 49.153531, longitude: 32.255226)

place = Place.create(name: 'Буда',
                     body: '14:00 - прибуття до дуба М.Залізняка та церкви Калнишевського. Вільний час. 17:30 - збір групи та виїзд до м.Черкаси',
                     tour_id: tour.id)

place.geolocations.create(locality: 'Дуб Залізняка', latitude: 49.109866, longitude: 32.260333)

place = Place.create(name: 'Черкаси',
                     body: '19:00 - Орієнтовний час приїзду до м.Черкаси',
                     tour_id: tour.id)

place.geolocations.create(locality: 'палац Дружби Народів', latitude: 49.437380, longitude: 32.072098)

# Caterings create

user = User.create(name: 'partner4', email: 'partner4@test.com', password: 'Partner456!', role: 1)

catering = Catering.create(name: 'YOSHI', description: 'Ресторан японської кухні', kind: 'ресторан',
                           address_owner: 'м.Черкаси, вул. Різдвяна 25', reg_code: '170999', person: 'Кияшко Роман Петрович',
                           places: 64, phone: '0472-383030', email: 'info@yoshi-fujiwara.ua', user_id: user.id)

catering.geolocations.create(locality: 'Черкаси', latitude: 49.441896, longitude: 32.064889, street: 'бул. Шевченка',
                             suite: '205', zip_code: '18001')

user = User.create(name: 'partner5', email: 'partner5@test.com', password: 'Partner567!', role: 1)

catering = Catering.create(name: 'Coffee House', description: 'Кафе в центрі міста Умань', kind: 'кафе',
                           address_owner: 'м.Умань, вул. Незалежності 75', reg_code: '171111', person: 'Іваненко Степан Петрович',
                           places: 24, phone: '+380 93 774 4124', email: 'info@coffeehouse.com.ua', user_id: user.id)

catering.geolocations.create(locality: 'Умань', latitude: 48.750112, longitude: 30.220777, street: 'вул. Небесної Сотні',
                             suite: '5', zip_code: '20300')

user = User.create(name: 'partner6', email: 'partner6@test.com', password: 'Partner678!', role: 1)

catering = Catering.create(name: 'Вітряк', kind: 'ресторан',
                           description: 'У ресторані представлені страви української кухні. Ви можете скуштувати тут смачний борщ, вареники та салати.',
                           address_owner: 'м.Корсунь-Шевченківський, вул. Незалежності 12', reg_code: '172222',
                           person: 'Симоненко Віктор Іванович', places: 118, phone: '+380 67 474 0168',
                           email: 'info@vitriak.com.ua', user_id: user.id)

catering.geolocations.create(locality: 'Корсунь-Шевченківський', latitude: 49.403294, longitude: 31.265759,
                             street: 'вул. Марценюка', suite: '2', zip_code: '19401')
