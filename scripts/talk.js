function reactOnAction()
{
    console.log("clicked!");

    var phrases = ['Панк - это дерзость\n и молодость мира! F.P.G',
                   'Укажут нам путь\nЛучи фонарей\nИ нам подпоют\nРваные петли подъездных дверей\n\nТуда, где нас ждут\nЗамёрзшие го-ро-да\nГде нам подпоют\nАртерии рек перезвонами льда...',
                   'Now remember the day\nWhen you left for Santa Monica\nYou left me to remain\nWith all your excuses for everything...\n\nNow remember the time\nWhen you left for Santa Monica\nAnd now remember the day, you told me, it\'s over',
                   'メリーゴーランドが止まらなくて\n廻る　廻る　景色が変わってく\nカラフルな夢を見る\nどくどくして　身体中を\n巡る　巡る　気持ち　まだ言葉に出来なくて\nひとこと　それで十\分なのに ',
                   'any rtl langs will not supported'];

    balloonLabel.text = phrases[Math.floor( Math.random() * phrases.length )];
}

function move()
{

}
