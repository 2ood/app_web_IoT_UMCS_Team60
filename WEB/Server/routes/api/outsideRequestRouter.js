const router = require('express').Router();
const dbPromiseConnection = require(`../../databasePromise`);
const managerAuth = require(`../../controllers/managerAuth`);

function nowDate() {
    let krDate = new Date();
    krDate.setHours(krDate.getHours()+9);
    return krDate.toISOString().slice(0, 10).replace('T', ' ');
}

router.get('/', async (req, res) => {
    var msg = {2:'not_found', 4: 'db_error'};
    try {
        var sql = "SELECT o.*, u.doom_id FROM outside_request o, user u WHERE o.user_tag=u.tag";
        var [results] = await dbPromiseConnection.query(sql);
        
        if(!results.length)
            return res.status(200).json({
                code: 2,
                msg: msg[2]
            });

        return res.status(200).json({
            code: 1,
            msg: "success",
            total: results.length,
            data: results
        });

    } catch(err) {
        console.log(err)
        return res.status(400).json({
            code: 4,
            msg: msg[4],
            err
        });
    }
});


router.get('/search', async (req, res) => {
    var msg = {2:'not_found', 4: 'db_error'};
    try {
        var sql = "SELECT o.*, u.doom_id FROM outside_request o, user u WHERE o.user_tag=u.tag ";
        for(key in req.query)
            sql += `AND ${key} = ? `;
        var [results] = await dbPromiseConnection.query(sql, Object.values(req.query));
        
        if(!results.length)
            return res.status(200).json({
                code: 2,
                msg: msg[2]
            });

        return res.status(200).json({
            code: 1,
            msg: "success",
            total: results.length,
            data: results
        });

    } catch(err) {
        console.log(err)
        return res.status(400).json({
            code: 4,
            msg: msg[4],
            err
        });
    }
});


router.get('/waiting_permission', managerAuth.checkLogin, async (req, res) => {
    var msg = {2:'not_found', 3:'not_found',4: 'db_error'};
    try {
        let sql = "SELECT * FROM watchman WHERE manager_tags=? AND responsible_date=? ";
        let [chargeDooms] = await dbPromiseConnection.query(sql, [req.user.tag, nowDate()]);

        if(!chargeDooms.length)
            return res.status(200).json({
                code: 3,
                msg: msg[3],
            });

        sql = "SELECT o.*, u.doom_id FROM outside_request o, user u WHERE o.user_tag=u.tag AND o.permission IS NULL ";
        for(key in req.query)
            sql += `AND ${key} = ? `;
        var [results] = await dbPromiseConnection.query(sql, Object.values(req.query));
        
        if(!results.length)
            return res.status(200).json({
                code: 2,
                msg: msg[2]
            });
        
        // 오늘 근무지인 곳에서 온 요청만 조회
        results = results.filter((e) => chargeDooms.find(ee=>ee.charge_doom === e.doom_id));

        return res.status(200).json({
            code: 1,
            msg: "success",
            total: results.length,
            data: results
        });

    } catch(err) {
        console.log(err)
        return res.status(400).json({
            code: 4,
            msg: msg[4],
            err
        });
    }
});


router.get('/:id', async (req, res) => {
    var msg = {2:'not_found', 4: 'db_error'};
    try {
        var sql = "SELECT o.*, u.doom_id FROM outside_request o, user u WHERE o.user_tag=u.tag AND id=?"
        var [results] = await dbPromiseConnection.query(sql, [req.params.id]);
        
        if(!results.length)
            return res.status(200).json({
                code: 2,
                msg: msg[2]
            });

        return res.status(200).json({
            code: 1,
            msg: "success",
            data: results[0]
        });

    } catch(err) {
        console.log(err)
        return res.status(400).json({
            code: 4,
            msg: msg[4],
            err
        });
    }
});

module.exports = router;