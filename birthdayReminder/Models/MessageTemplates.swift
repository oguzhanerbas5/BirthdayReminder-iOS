//
//  MessageTemplates.swift
//  birthdayReminder
//

import Foundation

struct Subcategory {
    let name: String
    let messages: [String]
}

struct MainCategory {
    let name: String
    let icon: String
    let subcategories: [Subcategory]
}

struct MessageTemplates {
    
    static let mainCategories: [MainCategory] = [
        MainCategory(
 name:"Romantik",
 icon:"heart.fill",
            subcategories: [
 Subcategory(name:"Sevgili", messages: sevgiliMessages),
 Subcategory(name:"Eş", messages: esMessages),
 Subcategory(name:"Koca", messages: kocaMessages),
 Subcategory(name:"Karım / Eşim", messages: karimMessages),
 Subcategory(name:"Flört", messages: flortMessages),
 Subcategory(name:"Hoşlandığım Kişi", messages: hoslandigimMessages),
 Subcategory(name:"Eski Sevgili", messages: eskiSevgiliMessages)
            ]
        ),
        MainCategory(
 name:"Arkadaşlar",
 icon:"person.2.fill",
            subcategories: [
 Subcategory(name:"En Yakın Arkadaş", messages: enYakinArkadasMessages),
 Subcategory(name:"Kanka", messages: kankaMessages),
 Subcategory(name:"Yakın Arkadaş", messages: yakinArkadasMessages),
 Subcategory(name:"Uzak Arkadaş", messages: uzakArkadasMessages),
 Subcategory(name:"Çocukluk Arkadaşı", messages: cocuklukArkadasiMessages),
 Subcategory(name:"Okul Arkadaşı", messages: okulArkadasiMessages),
 Subcategory(name:"İş Arkadaşı", messages: isArkadasiMessages),
 Subcategory(name:"Yeni Tanıştığım Arkadaş", messages: yeniTanistigimMessages)
            ]
        ),
        MainCategory(
 name:"Aile",
 icon:"house.fill",
            subcategories: [
 Subcategory(name:"Anne", messages: anneMessages),
 Subcategory(name:"Baba", messages: babaMessages),
 Subcategory(name:"Kardeş", messages: kardesMessages),
 Subcategory(name:"Abla", messages: ablaMessages),
 Subcategory(name:"Abi", messages: abiMessages),
 Subcategory(name:"Kız Kardeş", messages: kizKardesMessages),
 Subcategory(name:"Erkek Kardeş", messages: erkekKardesMessages),
 Subcategory(name:"Oğul", messages: ogulMessages),
 Subcategory(name:"Kızım", messages: kizimMessages),
 Subcategory(name:"Yeğen", messages: yegenMessages)
            ]
        ),
        MainCategory(
 name:"Akrabalar",
 icon:"sparkles",
            subcategories: [
 Subcategory(name:"Babaanne", messages: babaanneMessages),
 Subcategory(name:"Anneanne", messages: anneanneMessages),
 Subcategory(name:"Dede", messages: dedeMessages),
 Subcategory(name:"Amca", messages: amcaMessages),
 Subcategory(name:"Hala", messages: halaMessages),
 Subcategory(name:"Dayı", messages: dayiMessages),
 Subcategory(name:"Teyze", messages: teyzeMessages),
 Subcategory(name:"Kuzen", messages: kuzenMessages),
 Subcategory(name:"Enişte", messages: enisteMessages),
 Subcategory(name:"Yenge", messages: yengeMessages)
            ]
        ),
        MainCategory(
 name:"İş & Sosyal Çevre",
 icon:"briefcase.fill",
            subcategories: [
 Subcategory(name:"Patron / Yönetici", messages: patronMessages),
 Subcategory(name:"İş Arkadaşı", messages: isArkadasiMessages),
 Subcategory(name:"Öğretmen", messages: ogretmenMessages),
 Subcategory(name:"Mentor", messages: mentorMessages),
 Subcategory(name:"Komşu", messages: komsuMessages),
 Subcategory(name:"Eski İş Arkadaşı", messages: eskiIsArkadasiMessages)
            ]
        ),
        MainCategory(
 name:"Özel / Eğlenceli",
 icon:"star.fill",
            subcategories: [
 Subcategory(name:"Çok Yakın Biri", messages: cokYakinBiriMessages),
 Subcategory(name:"Değer Verdiğim Biri", messages: degerVerdigimBiriMessages),
 Subcategory(name:"Resmi / Kibar", messages: resmiKibarMessages),
 Subcategory(name:"Komik", messages: komikMessages),
 Subcategory(name:"Duygusal", messages: duygusalMessages),
 Subcategory(name:"Kısa ve Samimi", messages: kisaSamimiMessages),
 Subcategory(name:"Uzun ve Anlamlı", messages: uzunAnlamliMessages)
            ]
        )
    ]

    // MARK: - Exact Messages

    static let sevgiliMessages = [
        "İyi ki doğdun sevgilim {NAME}! Hayatıma girdiğin günden beri birçok şey daha güzel. Yeni yaşında yüzünün hep gülmesi ve tüm hayallerinin gerçekleşmesi dileğiyle. Seni çok seviyorum.",
        "Doğum günün kutlu olsun aşkım {NAME}! Seninle geçirdiğim her an benim için çok değerli. Yeni yaşında da el ele, birlikte nice güzel anılar biriktirelim. İyi ki varsın.",
        "Bugün benim için de özel bir gün, çünkü hayatımdaki en güzel insan doğmuş. İyi ki doğdun sevgilim {NAME}! Nice mutlu, sağlıklı ve birlikte geçireceğimiz yıllara.",
        "Yeni yaşın sana kalbin kadar güzel günler getirsin aşkım {NAME}. Her sabah yüzünde bir gülümsemeyle uyanman dileğiyle. İyi ki doğdun.",
        "Seni tanıdığım için, seni sevdiğim için kendimi çok şanslı hissediyorum. Doğum günün kutlu olsun sevgilim {NAME}. Nice güzel yaşlara birlikte!",
        "İyi ki doğdun hayatım {NAME}! Bugün tüm dileklerin gerçek olsun. Benim tek dileğim var: Yeni yaşlarında da hep yanında olabilmek. Seni çok seviyorum.",
        "Birlikte geçirdiğimiz her yıl benim için ayrı bir güzellik. Umarım yeni yaşın da beraber yaşayacağımız unutulmaz anılarla dolu olur. İyi ki doğdun sevgilim {NAME}!",
        "Doğum günün kutlu olsun güzelim {NAME}. Hayatının her döneminde yanında seni seven insanların olması dileğiyle. Seni çok seviyorum.",
        "Bugün senin doğum günün ama hediyeyi aslında ben aldım: Seni hayatımda. Yeni yaşında sağlık, mutluluk ve bolca kahkaha diliyorum. İyi ki doğdun aşkım {NAME}!",
        "Nice yaşlara sevgilim {NAME}! Yeni yaşının hayatındaki en güzel başlangıçlardan biri olmasını diliyorum. Birlikte daha nice doğum günlerine!"
    ]

    static let esMessages = [
        "Doğum günün kutlu olsun hayat arkadaşım {NAME}. Hayatın tüm güzelliklerini seninle paylaşabildiğim için kendimi çok şanslı hissediyorum. Nice sağlıklı, huzurlu yıllara.",
        "İyi ki doğdun eşim {NAME}! Seninle aynı hayatı paylaşmak, birlikte büyümek benim için en güzel şeylerden biri. Seni çok seviyorum.",
        "Yeni yaşında gönlünden geçen her şeyin gerçekleşmesini diliyorum. Hayatımız boyunca sağlıkla, huzurla nice güzel yıllar geçirelim. İyi ki varsın eşim {NAME}.",
        "Sen sadece eşim değil, aynı zamanda en yakın arkadaşımsın. İyi ki doğdun {NAME}. Nice güzel yaşlara birlikte!",
        "Her yeni yaşında sana baktığımda ne kadar güzel bir hayat arkadaşım olduğunu bir kez daha anlıyorum {NAME}. Doğum günün kutlu olsun.",
        "İyi ki doğdun canım eşim {NAME}. Birlikte geçirdiğimiz yılların üzerine daha nice güzel yıllar eklemek dileğiyle. Sağlık ve huzur hep bizimle olsun.",
        "Bugün senin günün {NAME}. Dilerim hayatımız boyunca yüzündeki o güzel gülümsemeyi hiç kaybetmezsin. İyi ki hayatımdasın.",
        "Doğum günün kutlu olsun {NAME}. Seninle yaşadığım her güzel an için minnettarım. Yeni yaşında birlikte nice hayallere!",
        "Hayatın bana verdiği en güzel hediyelerden biri sensin {NAME}. Yeni yaşında sağlık, huzur ve mutluluk seninle olsun. İyi ki doğdun eşim.",
        "Nice yaşlara hayat arkadaşım {NAME}. Bugün bir yaş daha aldın ama benim gözümde her zamanki kadar güzelsin. Seni seviyorum!"
    ]

    static let kocaMessages = [
        "İyi ki doğdun canım kocam {NAME}! Hayatın bütün güzelliklerinin seni bulmasını diliyorum. Sağlıkla, mutlulukla geçireceğimiz nice yaşlarımız olsun.",
        "Doğum günün kutlu olsun hayat arkadaşım {NAME}. Seninle aynı hayatı paylaşmak benim için büyük bir mutluluk. İyi ki varsın.",
        "Yeni yaşında bütün dileklerinin gerçekleşmesini diliyorum. Her zaman sağlıklı, mutlu ve huzurlu ol. Seni çok seviyorum kocam {NAME}!",
        "Birlikte geçirdiğimiz her yıl için şükrediyorum. Daha nice doğum günlerini beraber kutlamak dileğiyle. İyi ki doğdun sevgilim {NAME}.",
        "Canım kocam {NAME}, doğum günün kutlu olsun! Hayatın boyunca hep güzel insanlarla ve mutlulukla karşılaşman dileğiyle.",
        "Sen benim hayat arkadaşım, sırdaşım ve en güvendiğim insansın {NAME}. İyi ki doğdun. Yüzün hep gülsün.",
        "Bugün senin doğum günün ve söylemek istediğim tek şey şu: İyi ki hayatımda varsın {NAME}. Nice mutlu yaşlara kocam!",
        "Yeni yaşın sana bolca sağlık, huzur ve mutluluk getirsin {NAME}. Birlikte geçireceğimiz daha nice güzel yıllarımız olsun.",
        "Doğum günün kutlu olsun canım {NAME}. Seninle yaşlanmak bile güzel bir hayal. Nice doğum günlerine!",
        "İyi ki doğdun hayatım {NAME}. Hayat yolculuğumuzda birlikte daha nice güzel duraklara ulaşalım. Seni çok seviyorum!"
    ]

    static let karimMessages = [
        "İyi ki doğdun güzel eşim {NAME}! Hayatımın en güzel parçalarından biri olduğun için çok mutluyum. Yeni yaşında hep mutlu ol.",
        "Doğum günün kutlu olsun hayatım {NAME}. Seninle geçen her gün benim için ayrı bir değer taşıyor. Nice güzel yaşlarımıza!",
        "Canım eşim {NAME}, yeni yaşın kalbin kadar güzel olsun. Hayat sana hep hak ettiğin güzellikleri getirsin. İyi ki varsın.",
        "Seni hayatımda gördüğüm her gün kendimi daha şanslı hissediyorum. Doğum günün kutlu olsun {NAME}. Seni çok seviyorum.",
        "İyi ki doğdun sevgilim {NAME}, iyi ki eşim oldun. Birlikte geçirdiğimiz her yılın üzerine nice güzel yıllar eklemek dileğiyle.",
        "Bugün senin günün güzel eşim {NAME}. Dilerim yeni yaşında bütün hayallerin gerçekleşir ve gülümsemen hiç eksilmez.",
        "Hayatımın en güzel yolculuğunda yanımda olduğun için teşekkür ederim {NAME}. Nice sağlıklı, huzurlu ve sevgi dolu yaşlara.",
        "Doğum günün kutlu olsun canım {NAME}. Seninle birlikte yaşlanmak ve her yeni yaşını yanında karşılamak benim için en güzel dilek.",
        "İyi ki doğdun eşim {NAME}! Hayatımızın bundan sonraki yıllarının da sevgi, huzur ve kahkahayla dolu olması dileğiyle.",
        "Senin doğduğun gün, bugün hayatımda olan en güzel insanın dünyaya geldiği gün. İyi ki doğdun güzel eşim {NAME}."
    ]

    static let flortMessages = [
        "Doğum günün kutlu olsun {NAME}! Yeni yaşının bolca mutluluk, güzel sürprizler ve güzel insanlarla dolu olmasını diliyorum.",
        "İyi ki doğdun {NAME}! Bugün seni biraz daha fazla gülümsetmek istedim. Yeni yaşında tüm dileklerinin gerçekleşmesi dileğiyle.",
        "Yeni yaşın kutlu olsun {NAME}! Seni tanıdığım için zaten güzel bir sürprizle karşılaşmıştım, umarım yeni yaşın da böyle sürprizlerle devam eder.",
        "Doğum günün kutlu olsun {NAME}. Umarım bugün aldığın mesajlar arasında yüzünü en çok güldürenlerden biri benimki olur.",
        "İyi ki doğdun {NAME}! Yeni yaşında bolca mutluluk diliyorum. Belki bu yıl birlikte kutlayacağımız başka güzel günler de olur.",
        "Bugün senin doğum günün {NAME} ama itiraf etmeliyim, seni tanımış olmak benim için de güzel bir hediye. İyi ki doğdun!",
        "Nice yaşlara {NAME}! Umarım yeni yaşın en az gülüşün kadar güzel geçer. Bugün bol bol gülmeyi unutma.",
        "Doğum günün kutlu olsun {NAME}! Yeni yaşında karşına güzel fırsatlar ve belki biraz da güzel tesadüfler çıksın.",
        "İyi ki doğdun {NAME}! Bugün dilek tutarken dikkatli ol, bazı dilekler beklenmedik şekilde gerçekleşebilir.",
        "Nice güzel yaşlara {NAME}! Umarım yeni yaşında mutluluğun hiç eksilmez. Ve belki yeni yaşının güzel anılarından birkaçında ben de olurum."
    ]

    static let hoslandigimMessages = [
        "Doğum günün kutlu olsun {NAME}! Yeni yaşında hayatının çok güzel geçmesini ve yüzünün hep gülmesini diliyorum.",
        "İyi ki doğdun {NAME}! Seni tanıdığım için gerçekten mutluyum. Umarım yeni yaşın sana kalbinin istediği her şeyi getirir.",
        "Bugün senin günün {NAME}! Umarım bolca gülümser, güzel insanlarla güzel anılar biriktirirsin. Nice yaşlara!",
        "Doğum günün kutlu olsun {NAME}. Yeni yaşında çok güzel başlangıçların ve unutamayacağın anıların olsun.",
        "İyi ki doğdun {NAME}! Umarım hayatının bu yeni yaşı sana beklediğinden çok daha güzel sürprizler getirir.",
        "Nice yaşlara {NAME}! Bugün dileğin ne bilmiyorum ama umarım gerçekleşmesi için gereken tüm güzellikler karşına çıkar.",
        "Doğum günün kutlu olsun {NAME}! Yeni yaşında mutluluk, huzur ve bolca güzel anı diliyorum. Umarım bugün çok özel geçer.",
        "İyi ki doğdun {NAME}! Umarım yeni yaşın hayatındaki en güzel yıllardan biri olur. Hep böyle güzel gülümsemen dileğiyle.",
        "Yeni yaşın kutlu olsun {NAME}! Seni biraz daha yakından tanıma fırsatı bulduğum için mutluyum.",
        "Nice yaşlara {NAME}! Bugün doğum gününü kutlayan birçok insan olacaktır ama ben sana sadece şunu söylemek istiyorum: İyi ki doğdun."
    ]

    static let eskiSevgiliMessages = [
        "Doğum günün kutlu olsun {NAME}. Yeni yaşında sağlık, huzur ve mutluluk diliyorum. Umarım hayatında her şey gönlünce olur.",
        "Nice yaşlara {NAME}. Geçmişte birlikte paylaştığımız güzel anılar için teşekkür ederim. Yeni yaşın güzel başlangıçlar getirsin.",
        "İyi ki doğdun {NAME}. Hayatının bundan sonraki döneminde hep mutlu olmanı ve güzel insanlarla karşılaşmanı diliyorum.",
        "Doğum günün kutlu olsun {NAME}. Umarım yeni yaşın sana huzur, sağlık ve hayallerine ulaşacağın güzel günler getirir.",
        "Yeni yaşında her şeyin gönlünce olmasını dilerim {NAME}. Geçmişte yaşadığımız güzel şeyleri güzel hatıralar olarak saklıyorum.",
        "İyi ki doğdun {NAME}. Hayatında yeni bir yaş, yeni başlangıçlar ve güzel günler olsun. Mutlu olmanı gerçekten diliyorum.",
        "Doğum günün kutlu olsun {NAME}. Umarım bugün sevdiklerinle birlikte güzel ve huzurlu bir gün geçirirsin. Nice yaşlara.",
        "Yeni yaşında sağlık, mutluluk ve başarı diliyorum {NAME}. Umarım hayat sana hak ettiğin güzellikleri getirir. İyi ki doğdun.",
        "Nice güzel yaşlara {NAME}. Hayatımız farklı yönlere gitmiş olsa da bugün doğum gününü kutlamadan geçmek istemedim. Mutlu yıllar.",
        "Doğum günün kutlu olsun {NAME}. Umarım önündeki yıllar sana geçmişten çok daha güzel anılar ve güzel başlangıçlar getirir."
    ]

    static let enYakinArkadasMessages = [
        "İyi ki doğdun canım dostum {NAME}! Hayatımın en güzel anılarının birçoğunda sen varsın. Daha nice yılları beraber gülerek geçirmek dileğiyle!",
        "Doğum günün kutlu olsun kardeşim {NAME}! İyi günde kötü günde yanımda olduğun için teşekkür ederim. İyi ki hayatımdasın!",
        "Birlikte yaşadığımız tüm saçmalıkları bir kenara bırakırsak, gerçekten harika bir dostluğumuz var. İyi ki doğdun {NAME}!",
        "İyi ki doğdun dostum {NAME}! Hayatımda senin gibi güvenebileceğim birinin olması benim için büyük şans. Yeni yaşında tüm güzellikler seni bulsun.",
        "Nice yaşlara kardeşim {NAME}! Daha beraber yapacağımız çok şey, güleceğimiz çok konu ve yaşayacağımız çok macera var!",
        "Doğum günün kutlu olsun {NAME}! Hayatımda olduğun için gerçekten mutluyum. Umarım yeni yaşın sana hak ettiğin tüm güzellikleri getirir.",
        "Kardeşim {NAME}, bugün bir yaş daha aldın ama merak etme, beraber olduğumuz sürece yaşlanmak o kadar da kötü değil. İyi ki doğdun!",
        "İyi ki varsın dostum {NAME}. Herkes hayatımıza girip çıkabilir ama bazı insanlar gerçekten kalır. Sen de onlardan birisin.",
        "Doğum günün kutlu olsun {NAME}! Yeni yaşında bolca kahkaha, bolca macera ve mümkün olduğunca az stres diliyorum.",
        "İyi ki doğdun canım dostum {NAME}. Daha nice doğum günlerinde aynı masada oturup eski günlere gülerek bakmak dileğiyle!"
    ]

    static let kankaMessages = [
        "İyi ki doğdun kankam {NAME}! Yaşlanıyoruz ama en azından beraber yaşlanıyoruz. Nice bol kahkahalı yıllara!",
        "Doğum günün kutlu olsun kardeşim {NAME}! Yeni yaşında bol para, bol mutluluk, bol tatil ve az problem diliyorum.",
        "Nice yaşlara kanka {NAME}! Yaşını söylemeyeceğim, çünkü dostluğumuzun hatırına susuyorum.",
        "İyi ki doğdun reis {NAME}! Yeni yaşında tüm hedeflerini gerçekleştirmeni diliyorum. Gerçekleştiremezsen de beraber dertleşiriz.",
        "Kankam {NAME}, yeni yaşın kutlu olsun! Hayat sana hep güzel fırsatlar çıkarsın. Çıkmazsa beraber fırsat yaratırız.",
        "Bir yaş daha aldın ama hâlâ akıllanmadın {NAME}. Neyse, seni böyle kabul ettik. İyi ki doğdun kanka!",
        "Doğum günün kutlu olsun {NAME}! Yeni yaşında sağlık, mutluluk ve cebinde hiç bitmeyen para diliyorum.",
        "İyi ki doğdun kardeşim {NAME}! Hayatın boyunca yüzün gülsün, kafan rahat olsun, çevrende de bizim gibi kaliteli insanlar olsun.",
        "Nice yaşlara kankam {NAME}! Pastayı yerken kalorileri sayma, bugün doğum günü. Yarın yine sayarsın.",
        "İyi ki doğdun kanka {NAME}! Yeni yaşında bol macera, bol kahkaha ve anlatacak daha çok hikâyemiz olsun. Nice yıllara!"
    ]

    static let yakinArkadasMessages = [
        "Doğum günün kutlu olsun {NAME}! Yeni yaşında sağlık, mutluluk ve güzel anılarla dolu bir yıl geçirmeni diliyorum. İyi ki varsın!",
        "İyi ki doğdun {NAME}! Hayatındaki tüm güzel şeylerin yeni yaşında daha da çoğalması dileğiyle. Nice mutlu yıllara!",
        "Nice yaşlara {NAME}! Umarım yeni yaşın sana bolca güzel haber, güzel insan ve güzel anı getirir.",
        "Doğum günün kutlu olsun {NAME}! Seni tanıdığım için gerçekten mutluyum. Yeni yaşında her şey gönlünce olsun.",
        "İyi ki doğdun {NAME}! Yeni yaşında sağlık, huzur, başarı ve bolca mutluluk diliyorum. Çok güzel bir yıl geçirmen dileğiyle.",
        "Bugün senin günün {NAME}! Umarım sevdiklerinle birlikte çok güzel bir doğum günü geçirirsin. Nice mutlu yaşlara!",
        "Yeni yaşın kutlu olsun {NAME}! Önündeki yılın bugüne kadar yaşadığın en güzel yıllardan biri olması dileğiyle.",
        "Doğum günün kutlu olsun {NAME}! Hayatında güzel başlangıçların ve unutamayacağın anıların çoğaldığı bir yaş olsun.",
        "Nice yaşlara {NAME}! Umarım yeni yaşında tüm hedeflerine biraz daha yaklaşır ve bolca güzel anı biriktirirsin.",
        "İyi ki doğdun {NAME}! Sağlık, mutluluk ve huzur dolu bir yaş geçirmen dileğiyle. Her şey gönlünce olsun!"
    ]

    static let uzakArkadasMessages = [
        "Doğum günün kutlu olsun {NAME}! Aramızda mesafeler olsa da güzel dileklerimi göndermeyi unutmadım. Yeni yaşın harika geçsin!",
        "Nice yaşlara {NAME}! Uzaklarda olsan da güzel anılarımızı unutmadım. Yeni yaşında bolca mutluluk diliyorum.",
        "İyi ki doğdun {NAME}! Mesafeler dostlukları değiştirmesin. Umarım yeni yaşında çok güzel şeyler yaşarsın.",
        "Doğum günün kutlu olsun {NAME}! En kısa zamanda tekrar görüşmek ve yeni anılar biriktirmek dileğiyle. Nice mutlu yaşlara!",
        "Yeni yaşın kutlu olsun {NAME}! Uzakta olsan da bugün seni hatırlamadan geçmek istemedim. Sağlık ve başarı seninle olsun.",
        "İyi ki doğdun {NAME}! Umarım bulunduğun yerde çok güzel bir yıl geçirirsin. Bir sonraki doğum gününü belki beraber kutlarız.",
        "Nice yaşlara {NAME}! Araya mesafeler girse de dostluk aynı kalıyor. Yeni yaşında her şey gönlünce olsun.",
        "Doğum günün kutlu olsun {NAME}! Umarım yeni yaşın sana güzel yolculuklar, güzel insanlar ve unutulmaz anılar getirir.",
        "İyi ki doğdun {NAME}! Uzaklardan kocaman bir doğum günü selamı gönderiyorum. Umarım bugün bol bol gülersin.",
        "Nice güzel yaşlara {NAME}! Mesafelerin bizi daha az görüştürmesine izin versek de seni unutmamıza izin vermiyoruz!"
    ]

    static let cocuklukArkadasiMessages = [
        "İyi ki doğdun çocukluk arkadaşım {NAME}! Birlikte büyüdük, birlikte geliştik. Daha nice yılları beraber görmek dileğiyle!",
        "Doğum günün kutlu olsun {NAME}! Çocukluk anılarımıza yenilerini eklemek ve daha nice doğum günlerini beraber kutlamak dileğiyle.",
        "Nice yaşlara eski dost {NAME}! Çocukken yaptığımız saçmalıkları bugün hatırlayıp gülüyoruz. Yaşlandıkça hikâyeler daha komik olacak!",
        "İyi ki doğdun {NAME}! Çocukluğumdan bugüne hayatımda olan nadir insanlardan birisin. İyi ki varsın.",
        "Yeni yaşın kutlu olsun kardeşim {NAME}! Hayat bizi farklı yerlere götürse bile çocukluktan gelen dostluğumuz hep devam etsin.",
        "Doğum günün kutlu olsun {NAME}! Birlikte büyüdüğümüz yılların üzerine daha nice güzel yıllar eklemek dileğiyle.",
        "İyi ki doğdun eski dost {NAME}! Yaşlarımız büyüdü ama çocukken yaptığımız saçmalıkları hâlâ unutmadık. Nice yaşlara!",
        "Nice mutlu yaşlara {NAME}! Çocukluk anılarımızın her biri ayrı güzel. Umarım bundan sonra da birlikte güzel anılar biriktiririz.",
        "Doğum günün kutlu olsun {NAME}! Yıllar geçse de çocukluktan gelen bazı dostlukların değeri hiç değişmiyor. İyi ki varsın.",
        "İyi ki doğdun dostum {NAME}! Çocukken başlayan dostluğumuzun hayatımız boyunca devam etmesi dileğiyle. Nice güzel yaşlara!"
    ]

    static let okulArkadasiMessages = [
        "Doğum günün kutlu olsun {NAME}! Okul yıllarından kalan güzel arkadaşlıklardan biri olduğun için mutluyum. Başarı seninle olsun!",
        "İyi ki doğdun {NAME}! Derslerin, sınavların ve ödevlerin arasında bugün biraz eğlenmeyi hak ettin. Nice güzel yaşlara!",
        "Doğum günün kutlu olsun {NAME}! Umarım yeni yaşında hem okul hayatında hem özel hayatında her şey gönlünce olur.",
        "Nice yaşlara {NAME}! Yeni yaşında sınavların kolay, notların yüksek, stresin az olsun.",
        "İyi ki doğdun {NAME}! Birlikte geçirdiğimiz okul günlerine daha nice güzel anılar eklemek dileğiyle. Mutlu yıllar!",
        "Yeni yaşın kutlu olsun {NAME}! Umarım bu yıl sadece derslerde değil, hayatın her alanında güzel başarılar elde edersin.",
        "Doğum günün kutlu olsun {NAME}! Yeni yaşında bolca başarı, mutluluk ve tabii ki az sınav diliyorum.",
        "İyi ki doğdun {NAME}! Okul arkadaşlığı bazen yıllar sonra bile devam eden güzel bir dostluğa dönüşüyor. Nice yıllara!",
        "Nice mutlu yaşlara {NAME}! Yeni yaşında hedeflerine ulaşmanı ve bolca güzel anı biriktirmeni diliyorum.",
        "Doğum günün kutlu olsun {NAME}! Bugün ders yok, ödev yok, sınav yok. Sadece doğum gününü kutlamak var. Nice yaşlara!"
    ]

    static let isArkadasiMessages = [
        "Doğum günün kutlu olsun {NAME}! Yeni yaşında sağlık, mutluluk ve kariyerinde bolca başarı diliyorum. Nice güzel yaşlara!",
        "İyi ki doğdun {NAME}! Yeni yaşının güzel fırsatlar, başarılı projeler ve bolca mutluluk getirmesi dileğiyle.",
        "Nice yaşlara {NAME}! Umarım yeni yaşında hem iş hayatında hem özel hayatında her şey istediğin gibi gider.",
        "Doğum günün kutlu olsun {NAME}! Yeni yaşında hedeflerine ulaşmanı, güzel başarılara imza atmanı dilerim.",
        "İyi ki doğdun {NAME}! Bugün toplantıları, mailleri ve işleri biraz kenara bırakıp doğum gününün tadını çıkar!",
        "Yeni yaşın kutlu olsun {NAME}! Sağlık, mutluluk, başarı ve mümkün olduğunca az stres diliyorum.",
        "Doğum günün kutlu olsun {NAME}! Umarım yeni yaşın kariyerinde güzel gelişmelerin ve hayatında güzel başlangıçların olduğu bir yıl olur.",
        "Nice mutlu yaşlara {NAME}! Birlikte çalıştığımız süre boyunca güzel bir çalışma arkadaşı olduğun için teşekkür ederim.",
        "İyi ki doğdun {NAME}! Yeni yaşında emeklerinin karşılığını aldığın, hedeflerine ulaştığın bir yıl diliyorum.",
        "Doğum günün kutlu olsun {NAME}! Yeni yaşında işlerin yolunda, kahven sıcak, toplantıların kısa olsun."
    ]

    static let yeniTanistigimMessages = [
        "Doğum günün kutlu olsun {NAME}! Henüz yeni tanışmış olsak da güzel dileklerimi iletmek istedim. Yeni yaşın harika geçsin!",
        "İyi ki doğdun {NAME}! Seni tanıdığım için mutluyum. Umarım yeni yaşın güzel başlangıçlarla dolu olur.",
        "Nice yaşlara {NAME}! Yeni yaşında sağlık, mutluluk ve bolca güzel anı diliyorum.",
        "Doğum günün kutlu olsun {NAME}! Umarım önümüzdeki yıl hayatına güzel insanlar ve güzel fırsatlar getirir.",
        "İyi ki doğdun {NAME}! Yeni tanışmış olsak da bugün seni kutlamadan geçmek istemedim. Mutlu yıllar!",
        "Yeni yaşın kutlu olsun {NAME}! Umarım bu yıl senin için unutulmaz güzellikte bir yıl olur.",
        "Doğum günün kutlu olsun {NAME}! Yeni yaşında gönlünden geçen güzel şeylerin gerçekleşmesini diliyorum.",
        "Nice güzel yaşlara {NAME}! Umarım seni tanımaya başladığımız bu dönem güzel bir dostluğun başlangıcı olur.",
        "İyi ki doğdun {NAME}! Yeni yaşında bolca kahkaha, mutluluk ve güzel tesadüfler diliyorum.",
        "Doğum günün kutlu olsun {NAME}! Umarım yeni yaşın hayatındaki en güzel yıllardan biri olur. Nice yaşlara!"
    ]

    static let anneMessages = [
        "İyi ki doğdun canım annem! Hayatımdaki en değerli insansın. Bana verdiğin sevgi ve emek için teşekkür ederim. Nice sağlıklı yaşlara.",
        "Doğum günün kutlu olsun güzel annem. Her zaman yanımda olduğun ve sevgini hiç eksik etmediğin için çok şanslıyım. Seni çok seviyorum.",
        "İyi ki varsın, iyi ki benim annemsin. Yeni yaşında yüzünün hep gülmesini, sağlığının hiç eksilmemesini diliyorum.",
        "Canım annem, doğum günün kutlu olsun! Senin sevgin benim için dünyadaki en güzel şey. Hep birlikte nice yıllara.",
        "Bugün benim için çok özel çünkü hayatımdaki en özel insan doğmuş. İyi ki doğdun annem. Seni çok seviyorum.",
        "Yeni yaşın kutlu olsun canım annem. Bana verdiğin tüm emekler ve sevgiler için teşekkür ederim. Nice güzel yıllara.",
        "İyi ki doğdun annem! Hayatım boyunca bana verdiğin güç ve destek için minnettarım. Umarım tüm yılların mutlulukla geçer.",
        "Nice yaşlara güzel annem! Her yeni yaşında daha çok gülmeni ve sevdiklerinle huzurlu günler geçirmeni diliyorum.",
        "Doğum günün kutlu olsun annem. Senin gibi bir anneye sahip olduğum için kendimi çok şanslı hissediyorum. İyi ki varsın.",
        "İyi ki doğdun canım annem. Hayatım boyunca en büyük destekçim olduğun için teşekkür ederim. Seni çok seviyorum!"
    ]

    static let babaMessages = [
        "İyi ki doğdun canım babam! Hayatım boyunca bana verdiğin destek ve öğrettiğin değerler için teşekkür ederim. Nice sağlıklı yaşlara.",
        "Doğum günün kutlu olsun babacığım. Senin gibi bir babaya sahip olduğum için çok şanslıyım. Hep sağlıklı ve mutlu ol.",
        "İyi ki varsın babam. Bana hayat boyunca yol gösterdiğin ve her zaman yanımda olduğun için teşekkür ederim. Nice güzel yıllara.",
        "Canım babam, doğum günün kutlu olsun! Yeni yaşında sağlık, huzur ve mutluluk seninle olsun. Seni çok seviyorum.",
        "Bugün benim için çok özel bir gün. Çünkü hayatımın en önemli insanı doğmuş. İyi ki doğdun babam.",
        "Nice yaşlara babacığım! Umarım bundan sonraki tüm yılların sağlık ve sevdiklerinle birlikte geçirdiğin güzel günlerle dolsun.",
        "İyi ki doğdun babam! Bana güvenebileceğim bir rehber olduğun için teşekkür ederim. Nice yıllara!",
        "Doğum günün kutlu olsun canım babam. Yeni yaşında yüzünden gülümsemenin hiç eksilmemesi dileğiyle.",
        "Sana ne kadar teşekkür etsem az. Bugün olduğum insan olmamda büyük emeğin var. İyi ki doğdun babam.",
        "Nice sağlıklı ve mutlu yaşlara babacığım! Seni çok seviyorum. Her zaman yanımızda ve sağlıklı ol!"
    ]

    static let kardesMessages = [
        "İyi ki doğdun canım kardeşim {NAME}! Yeni yaşında tüm hayallerinin gerçekleşmesini ve yüzünün hep gülmesini diliyorum.",
        "Doğum günün kutlu olsun kardeşim {NAME}! Çocukluğumuzdan bugüne birlikte biriktirdiğimiz anılara nicelerini eklemek dileğiyle.",
        "İyi ki varsın kardeşim {NAME}. Hayatımda senin gibi bir kardeşimin olması büyük bir şans. Nice mutlu yaşlara!",
        "Canım kardeşim {NAME}, yeni yaşın kutlu olsun! Umarım hayat sana her zaman hak ettiğin güzellikleri getirir.",
        "İyi ki doğdun {NAME}! Bazen kavga etsek de sen benim için her zaman çok değerlisin.",
        "Nice yaşlara kardeşim {NAME}! Sağlık, mutluluk, başarı ve bolca güzel anı diliyorum. Hep mutlu ol.",
        "Doğum günün kutlu olsun kardeşim {NAME}. Hayatının her döneminde yanında olacağımı bilmeni isterim. Nice yaşlara!",
        "İyi ki doğdun {NAME}! Yeni yaşında hedeflerine ulaşmanı, hayallerinin peşinden gitmeni diliyorum.",
        "Canım kardeşim {NAME}, doğum günün kutlu olsun. Hayatın boyunca yüzündeki gülümseme hiç eksilmesin.",
        "Nice mutlu yaşlara kardeşim {NAME}! Birlikte daha nice doğum günlerini kutlamak ve güzel anılar biriktirmek dileğiyle."
    ]

    static let ablaMessages = [
        "İyi ki doğdun canım ablam {NAME}! Hayatımda her zaman özel bir yerin var. Yeni yaşında sağlık, mutluluk ve huzur diliyorum.",
        "Doğum günün kutlu olsun ablacığım {NAME}! Her zaman yanımda olduğun için teşekkür ederim. Nice güzel yaşlara!",
        "İyi ki varsın ablam {NAME}. Yeni yaşında tüm hayallerinin gerçekleşmesini ve yüzünün hep gülmesini diliyorum.",
        "Nice yaşlara güzel ablam {NAME}! Hayatın boyunca sevdiklerinle birlikte huzurlu ve mutlu günler geçirmen dileğiyle.",
        "Doğum günün kutlu olsun abla {NAME}! Çocukluktan bugüne kadar paylaştığımız tüm güzel anılara yenilerini eklemek dileğiyle.",
        "İyi ki doğdun canım ablam {NAME}. Seni çok seviyorum. Yeni yaşında sağlık, mutluluk ve başarı hep seninle olsun.",
        "Nice mutlu yaşlara ablacığım {NAME}! Her zaman kendinle gurur duyacağın ve mutlu olacağın bir yaş geçirmen dileğiyle.",
        "Doğum günün kutlu olsun {NAME}! Hayatındaki bütün güzel şeylerin yeni yaşında daha da çoğalması dileğiyle.",
        "İyi ki varsın ablam {NAME}! Senin gibi bir ablam olduğu için kendimi çok şanslı hissediyorum. Nice yaşlara!",
        "Canım ablam {NAME}, doğum günün kutlu olsun! Sağlık, huzur, mutluluk ve bolca güzel anıyla dolu bir yaş diliyorum."
    ]

    static let abiMessages = [
        "İyi ki doğdun ağabeyim {NAME}! Hayat boyunca bana verdiğin destek ve gösterdiğin yol için teşekkür ederim. Nice sağlıklı yaşlara.",
        "Doğum günün kutlu olsun abi {NAME}! Yeni yaşında sağlık, mutluluk ve başarı diliyorum. Hep güzel günler seninle olsun.",
        "İyi ki varsın ağabeyim {NAME}. Bazen bir kardeşten çok bir rehber oldun. Hayatımda olduğun için çok şanslıyım.",
        "Nice yaşlara abi {NAME}! Yeni yaşında tüm hedeflerine ulaşman ve emeklerinin karşılığını alman dileğiyle.",
        "Doğum günün kutlu olsun ağabey {NAME}! Sevdiklerinle birlikte sağlıklı, huzurlu ve mutlu nice yıllar geçirmen dileğiyle.",
        "İyi ki doğdun abi {NAME}. Her zaman yanımda olduğun için teşekkür ederim. Umarım yeni yaşın gönlünce geçer.",
        "Nice güzel yaşlara ağabeyim {NAME}! Hayatının her döneminde mutluluğun ve huzurun seninle olması dileğiyle.",
        "Doğum günün kutlu olsun abi {NAME}! Yeni yaşında güzel fırsatlar, başarılar ve bolca mutluluk diliyorum.",
        "İyi ki varsın ağabeyim {NAME}. Seninle daha nice güzel anılar biriktirmek dileğiyle. Nice yaşlara!",
        "Doğum günün kutlu olsun abi {NAME}! Sağlıkla, huzurla ve sevdiklerinle birlikte geçireceğin nice yıllara."
    ]

    static let kizKardesMessages = kardesMessages
    static let erkekKardesMessages = kardesMessages
    static let ogulMessages = kardesMessages
    static let kizimMessages = kardesMessages

    static let yegenMessages = [
        "İyi ki doğdun canım yeğenim {NAME}! Yeni yaşında yüzünün hep gülmesini, hayallerinin gerçekleşmesini diliyorum. Nice mutlu yaşlara!",
        "Doğum günün kutlu olsun güzel yeğenim {NAME}! Yeni yaşın bolca mutluluk, başarı ve güzel sürprizlerle dolu olsun.",
        "İyi ki doğdun {NAME}! Her yeni yaşında büyürken hayallerinin de büyümesi dileğiyle. Seni çok seviyoruz!",
        "Nice yaşlara canım yeğenim {NAME}! Hayatın boyunca hep güzel insanlarla karşılaş, yüzün hep gülsün.",
        "Bugün senin günün {NAME}! Yeni yaşında bolca eğlence, kahkaha ve unutamayacağın güzel anılar diliyorum.",
        "Doğum günün kutlu olsun tatlı yeğenim {NAME}! Hayatının her yaşının bir öncekinden daha güzel olması dileğiyle.",
        "İyi ki doğdun canım {NAME}! Tüm hayallerinin peşinden cesurca gitmeni diliyorum. Nice güzel yaşlara!",
        "Nice güzel yaşlara yeğenim {NAME}! Sağlık, mutluluk, başarı ve bolca güzel sürpriz seninle olsun.",
        "Doğum günün kutlu olsun {NAME}! Bugün bol bol pasta ye, bol bol gül. Yeni yaşın harika geçsin!",
        "İyi ki varsın canım yeğenim {NAME}! Seni her zaman mutlu, sağlıklı ve başarılı görmek dileğiyle. Nice yaşlara!"
    ]

    static let babaanneMessages = [
        "İyi ki doğdun canım babaannem {NAME}! Senin sevgini ve güzel dualarını hissetmek çok değerli. Nice sağlıklı ve huzurlu yaşlara.",
        "Doğum günün kutlu olsun güzel babaannem {NAME}! Hep bizimle, sağlıklı ve mutlu olmanı diliyorum. Seni çok seviyorum.",
        "İyi ki varsın babaannem {NAME}. Seninle geçirdiğimiz her an benim için çok kıymetli. Nice güzel yaşlara!",
        "Nice yaşlara canım babaannem {NAME}! Yüzündeki gülümsemenin ve evimize kattığın sıcaklığın hiç eksilmemesi dileğiyle.",
        "Doğum günün kutlu olsun babaannem {NAME}. Allah sana sağlık, huzur ve sevdiklerinle geçireceğin nice yıllar nasip etsin.",
        "İyi ki doğdun canım babaannem {NAME}! Seni çok seviyorum. Hep sağlıklı, mutlu ve huzurlu olmanı diliyorum.",
        "Bugün senin özel günün babaannem {NAME}. İyi ki hayatımızdasın, iyi ki bizimlesin. Nice sağlıklı yaşlara!",
        "Doğum günün kutlu olsun güzel babaannem {NAME}. Ailemizin en güzel değerlerinden birisin. Nice mutlu yıllara.",
        "Nice yaşlara babaannem {NAME}! Her yeni yaşında sevdiklerinle birlikte daha güzel günler geçirmeni diliyorum.",
        "İyi ki doğdun babaannem {NAME}! Sağlık, huzur ve mutlulukla geçireceğin nice yaşların olsun. Seni seviyorum!"
    ]

    static let anneanneMessages = babaanneMessages

    static let dedeMessages = [
        "İyi ki doğdun canım dedem {NAME}! Senin tecrübelerin ve güzel sohbetlerin benim için çok değerli. Nice sağlıklı yaşlara!",
        "Doğum günün kutlu olsun dedeciğim {NAME}! Hep sağlıklı, mutlu ve huzurlu olmanı diliyorum. İyi ki varsın.",
        "Nice yaşlara dedem {NAME}! Ailemizin en değerli insanlarından birisin. Seni çok seviyorum.",
        "İyi ki doğdun canım dedem {NAME}! Yeni yaşında sağlık, huzur ve sevdiklerinle birlikte güzel günler diliyorum.",
        "Doğum günün kutlu olsun dedeciğim {NAME}! Seninle daha nice güzel anılar biriktirmek dileğiyle.",
        "İyi ki varsın dedem {NAME}. Her zaman yanımızda olduğun için teşekkür ederim. Nice sağlıklı yıllara.",
        "Nice mutlu yaşlara dedem {NAME}! Yeni yaşında yüzünün hep gülmesi dileğiyle.",
        "Doğum günün kutlu olsun {NAME}! Senin gibi bir dedeye sahip olduğum için çok mutluyum. Nice güzel yaşlara.",
        "İyi ki doğdun dedeciğim {NAME}! Sağlık ve huzur içinde geçireceğin daha nice yaşların olsun.",
        "Nice yaşlara canım dedem {NAME}! İyi ki hayatımızdasın, iyi ki bizimlesin. Seni çok seviyorum."
    ]

    static let amcaMessages = [
        "Doğum günün kutlu olsun canım amcam {NAME}! Yeni yaşında sağlık, mutluluk ve huzur diliyorum. Nice güzel yaşlara!",
        "İyi ki doğdun amca {NAME}! Her zaman yüzünün güldüğü, sevdiklerinle güzel zamanlar geçirdiğin bir yaş olsun.",
        "Nice yaşlara amcam {NAME}! Ailemizin güzel insanlarından biri olduğun için çok mutluyum.",
        "Doğum günün kutlu olsun {NAME}! Yeni yaşında tüm dileklerinin gerçekleşmesini diliyorum.",
        "İyi ki doğdun canım amcam {NAME}! Sağlık, huzur ve mutluluk dolu nice yıllara.",
        "Nice mutlu yaşlara amca {NAME}! Umarım yeni yaşın güzel haberlerle ve güzel anılarla dolu olur.",
        "Doğum günün kutlu olsun amcam {NAME}! Bugünün sevdiklerinle birlikte çok güzel geçmesini diliyorum.",
        "İyi ki varsın amca {NAME}! Yeni yaşında hayatındaki tüm güzelliklerin çoğalması dileğiyle. Nice yaşlara!",
        "Doğum günün kutlu olsun canım amcam {NAME}. Sağlıklı, huzurlu ve mutlu bir yaş geçirmeni diliyorum.",
        "Nice yaşlara amca {NAME}! Yeni yaşında her şey gönlünce olsun. Sevdiklerin hep yanında olsun!"
    ]

    static let halaMessages = amcaMessages
    static let dayiMessages = amcaMessages
    static let teyzeMessages = amcaMessages
    static let kuzenMessages = enYakinArkadasMessages
    static let enisteMessages = amcaMessages
    static let yengeMessages = amcaMessages

    static let patronMessages = [
        "Doğum gününüz kutlu olsun {NAME}. Yeni yaşınızın sağlık, mutluluk ve başarılarla dolu geçmesini dilerim. Nice güzel yaşlara.",
        "Yeni yaşınızı en içten dileklerimle kutlarım {NAME}. Hem iş hayatınızda hem özel hayatınızda başarı diliyorum.",
        "Doğum gününüz kutlu olsun {NAME}. Yeni yaşınızda hedeflerinize ulaşmanız ve başarılı çalışmalarınızın devamı dileğiyle.",
        "Nice sağlıklı ve başarılı yaşlara {NAME}. Yeni yaşınızın size ve sevdiklerinize huzur getirmesini dilerim.",
        "Doğum gününüz kutlu olsun {NAME}. Birlikte çalıştığımız süreçteki katkılarınız ve liderliğiniz için teşekkür ederim.",
        "Yeni yaşınızın kariyerinizde yeni başarılar, hayatınızda ise sağlık getirmesini dilerim {NAME}. Kutlu olsun.",
        "Nice mutlu yaşlara {NAME}. Başarılarınızın üzerine yenilerini ekleyeceğiniz güzel bir yıl olması dileğiyle.",
        "Doğum gününüz kutlu olsun {NAME}. Sağlık, huzur, mutluluk ve başarı dolu nice yıllar geçirmenizi dilerim.",
        "Yeni yaşınızın hem kişisel hem profesyonel anlamda güzel fırsatlar getirmesi dileğiyle {NAME}. Kutlu olsun.",
        "Doğum gününüz kutlu olsun {NAME}. Yeni yaşınızda tüm hedeflerinize ulaşmanız dileğiyle."
    ]

    static let ogretmenMessages = [
        "Doğum gününüz kutlu olsun hocam {NAME}. Bize kattığınız bilgiler ve verdiğiniz emekler için teşekkür ederim. Nice yaşlara.",
        "İyi ki doğdunuz hocam {NAME}! Yeni yaşınızın sağlık, huzur ve mutlulukla geçmesini dilerim.",
        "Doğum gününüz kutlu olsun {NAME}. Öğrencilerinizin hayatına kattığınız değerlerin karşılığını mutluluk olarak almanız dileğiyle.",
        "Yeni yaşınızı en içten dileklerimle kutlarım hocam {NAME}. Her zaman sağlıklı ve başarılı olmanız dileğiyle.",
        "İyi ki doğdunuz hocam {NAME}! Bize yalnızca dersleri değil, hayata dair birçok şeyi öğrettiğiniz için teşekkürler.",
        "Doğum gününüz kutlu olsun hocam {NAME}. Yeni yaşınızın size bolca mutluluk ve huzur getirmesini dilerim.",
        "Nice sağlıklı yaşlara hocam {NAME}. Emeklerinizin ve öğrencileriniz üzerindeki güzel etkinizin devamı dileğiyle.",
        "Doğum gününüz kutlu olsun {NAME}! Sizin gibi öğretmenlerin öğrencilerinin hayatında bıraktığı iz çok değerli.",
        "İyi ki doğdunuz hocam {NAME}. Sağlıkla, huzurla ve mutlulukla geçireceğiniz nice güzel yıllar diliyorum.",
        "Doğum gününüz kutlu olsun hocam {NAME}! Yeni yaşınızın başarılarınız kadar güzel ve anlamlı geçmesi dileğiyle."
    ]

    static let mentorMessages = ogretmenMessages
    static let komsuMessages = patronMessages
    static let eskiIsArkadasiMessages = isArkadasiMessages

    static let cokYakinBiriMessages = enYakinArkadasMessages
    static let degerVerdigimBiriMessages = enYakinArkadasMessages
    static let resmiKibarMessages = patronMessages

    static let komikMessages = [
        "Doğum günün kutlu olsun {NAME}! Yaşını söylemeyeceğim, merak etme. Ben de matematikte o kadar iyi değilim.",
        "İyi ki doğdun {NAME}! Bir yaş daha aldın ama hâlâ genç görünüyorsun. En azından karanlıkta.",
        "Nice yaşlara {NAME}! Bugün kalori yok, yaş yok, sorumluluk yok. Sadece pasta var.",
        "Doğum günün kutlu olsun {NAME}! Yaşlanmak kaçınılmaz ama pasta yemek hâlâ ücretsiz terapi.",
        "İyi ki doğdun {NAME}! Yeni yaşında bol para, bol tatil ve mümkün olduğunca az “acil” mesaj diliyorum.",
        "Nice yaşlara {NAME}! Yaşın büyümüş olabilir ama olgunlaşmak zorunda değilsin.",
        "Doğum günün kutlu olsun {NAME}! Bir yıl daha geçti ve hâlâ hayatını çözemedin. Neyse, beraber çözeriz.",
        "İyi ki doğdun {NAME}! Bugün aynaya dikkatli bakma. Yaş aldığını fark edip moralini bozma. Pasta ye geçer.",
        "Yeni yaşın kutlu olsun {NAME}! Yaşlanmıyorsun, sadece deneyim puanı topluyorsun.",
        "Doğum günün kutlu olsun {NAME}! Yaşını sormayacağım. Dostluğumuzun devam etmesini istiyorum. Nice yaşlara!"
    ]

    static let duygusalMessages = [
        "İyi ki doğdun {NAME}. Hayatımda olduğun için kendimi gerçekten şanslı hissediyorum. Umarım yeni yaşın kalbinin hak ettiği güzellikleri getirir.",
        "Bugün senin doğduğun gün {NAME}. Belki sıradan bir gün ama seni tanıyan insanlar için hayatlarına güzel bir insanın girdiği gün.",
        "Yeni yaşında tek dileğim {NAME}, hayatın boyunca yüzünü güldüren insanların yanında olması. Çünkü sen güzel şeyleri hak ediyorsun.",
        "İyi ki varsın {NAME}. Hayat bazen zorlaşsa da yanında seni gerçekten seven insanların olduğunu unutma. Doğum günün kutlu olsun.",
        "Birlikte yaşadığımız her an {NAME}, yıllar geçtikçe daha değerli bir hatıraya dönüşüyor. Yeni yaşında güzel anılar biriktirmek dileğiyle.",
        "Doğum günün kutlu olsun {NAME}. Hayatının her yeni yaşında biraz daha mutlu ve kendinle gurur duyduğun günler yaşaman dileğiyle.",
        "Bazı insanlar hayatımıza tesadüfen girer ama bıraktıkları izler tesadüf değildir {NAME}. Sen de hayatımda iz bırakan birisin.",
        "Yeni yaşında geçmişteki güzel anıların sana mutluluk, gelecekteki hayallerinin ise umut vermesi dileğiyle {NAME}. Nice güzel yaşlara.",
        "Bugün bir yaş daha aldın {NAME} ama benim dileğim yaşının değil, mutluluğunun artması. Her zaman sağlıklı ve mutlu ol.",
        "Hayatındaki her yeni yaşın sana kendini daha çok sevdiğin ve daha çok gülümsediğin güzel günler getirmesi dileğiyle {NAME}."
    ]

    static let kisaSamimiMessages = [
        "İyi ki doğdun {NAME}! Nice mutlu yaşlara!",
        "Doğum günün kutlu olsun {NAME}! Yeni yaşın harika geçsin!",
        "Nice güzel yaşlara {NAME}! Hep mutlu ol, iyi ki varsın!",
        "İyi ki doğdun {NAME}! Sağlık, mutluluk ve huzur seninle olsun.",
        "Yeni yaşın kutlu olsun {NAME}! Tüm dileklerin gerçek olsun!",
        "Nice yaşlara {NAME}! Bol kahkahalı, güzel bir yaş olsun!",
        "Doğum günün kutlu olsun {NAME}! Her şey gönlünce olsun.",
        "İyi ki varsın, iyi ki doğdun {NAME}! Nice mutlu yıllara!",
        "Yeni yaşında bolca mutluluk diliyorum {NAME}. Nice yaşlara!",
        "Doğum günün kutlu olsun {NAME}! Sağlıklı ve mutlu nice yıllara!"
    ]

    static let uzunAnlamliMessages = [
        "Doğum günün kutlu olsun {NAME}. Yeni bir yaşa girerken geride bıraktığın tüm güzel anıların sana mutluluk vermesini, önündeki günlerin yepyeni umutlar ve fırsatlar getirmesini diliyorum. Sağlıklı, huzurlu nice yıllara.",
        "Bugün senin için yeni bir yaşın başlangıcı {NAME}. Umarım bu yeni yaşında geçmişteki deneyimlerinden güç alır, geleceğe umutla bakar ve hayalini kurduğun her şeye ulaşırsın. İyi ki doğdun, nice yaşlara!",
        "Yeni yaşının hayatında güzel bir dönemin başlangıcı olmasını diliyorum {NAME}. Sağlığının ve mutluluğunun hiç eksilmediği harika bir yıl olsun. Doğum günün kutlu olsun!",
        "Bir yıl daha geride kaldı ve hayatına yeni bir sayfa ekleniyor {NAME}. Umarım bu sayfa güzel haberlerle, başarılarla ve kahkahalarla dolar. Nice yaşlara!",
        "Doğum günün kutlu olsun {NAME}! Hayatın boyunca karşına çıkan zorlukların seni daha güçlü, güzel anların ise daha mutlu kılmasını diliyorum. Kendinle gurur duyacağın bir yıl olsun.",
        "Yeni yaşında sadece daha fazla yaş değil, daha fazla mutluluk ve güzel anı biriktirmeni diliyorum {NAME}. Değerini her zaman hissetmen dileğiyle. Nice güzel yaşlara.",
        "Bugün yeni bir yaşın kapısını açıyorsun {NAME}. Umarım bu kapının arkasında seni bekleyen çok güzel sürprizler vardır. Hayallerinin gerçekleştiği mutlu bir yıl diliyorum. İyi ki doğdun!",
        "Hayatın her zaman istediğin gibi ilerlemeyebilir ama umarım yeni yaşında her zorluğın ardından güzel bir başlangıç bulursun {NAME}. Kalbinin huzurla dolması dileğiyle. Kutlu olsun.",
        "Yeni yaşında geriye baktığında gurur duyacağın, ileriye baktığında heyecanlanacağın bir yıl geçirmeni diliyorum {NAME}. Nice güzel yaşlara!",
        "Doğum günün kutlu olsun {NAME}. Hayatındaki her yeni yaşın sana kendini biraz daha tanıdığın ve hayatın güzelliklerini daha fazla fark ettiğin bir dönem getirmesini diliyorum. Sağlıkla nice yıllara."
    ]
}
