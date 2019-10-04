<!DOCTYPE html><html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

    <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/extjs/6.2.0/ext-all-debug.js"></script>

    <link rel="stylesheet" type="text/css" href="http://cdnjs.cloudflare.com/ajax/libs/extjs/6.2.0/classic/theme-triton/resources/theme-triton-all-debug.css">
    <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/extjs/6.2.0/classic/theme-triton/theme-triton-debug.js"></script>

    <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/extjs/6.2.0/packages/charts/classic/charts-debug.js"></script>
    <link type="text/css" href="http://cdnjs.cloudflare.com/ajax/libs/extjs/6.2.0/packages/charts/classic/classic/resources/charts-all-debug.css">

    <script type="text/javascript">
        var zapisCitanjeGridUrl= "${g.createLink(controller: 'testKlasa', action: 'gridStore')}";
        Ext.define('Zapis', {
            extend: 'Ext.data.Model',
            fields: [
                {name: 'id',  type: 'integer'},
                {name: 'naziv',  type: 'string'},
                {name: 'postanskibroj',  type: 'string'}
            ]
        });

        Ext.tip.QuickTipManager.init();

        Ext.onReady(function() {

            var idgrad= Ext.get('idgrad').dom.value;

            var storeGrid = Ext.create('Ext.data.Store', {
                autoLoad: true,
                autoSync: true,
                model: 'Zapis',
                id: 'storeGrid',
                name: 'storeGrid',
                proxy: {
                    type: 'rest',
                    url: zapisCitanjeGridUrl,
                    reader: {
                        type: 'json',
                        rootProperty: 'data'
                    },
                    writer: {
                        type: 'json'
                    }
                },
                listeners:{
                    beforeload: function(store){
                        //store.getProxy().setExtraParam("idnabavke", idnabavke);
                    }
                }
            });

            var viewPort = Ext.create('Ext.container.Viewport', {
                layout : 'border',
                margin: '0',
                //padding: '5',
                items  : [
                    {
                        id:'northViewPortId',
                        layout:'fit',
                        height: 200,
                        width: '100%',
                        //minHeight: 280,
                        region : 'north'

                    },
                    {
                        id: 'southViewPortId',
                        layout: 'fit',
                        width: '100%',
                        height: window.innerHeight-200,
                        region: 'south'
                    }
                ]
            });

            var formPanel = Ext.create('Ext.form.Panel', {
                title: 'Grad',
                // width: '100%',
                // height: 670,
                // bodyPadding: 0,
                renderTo: Ext.getBody(),

                items: [
                    {
                        xtype: 'textfield',
                        id: 'naziv',
                        cls: 'field-margin',
                        allowBlank : false,
                        fieldLabel: 'Naziv',
                        labelAlign: 'right',
                        width: '350px'
                    },
                    {
                        xtype: 'textfield',
                        id: 'postanskibroj',
                        cls: 'field-margin',
                        fieldLabel: 'Poštanski broj',
                        labelAlign: 'right',
                        width: '350px'
                    },
                    {
                        xtype: 'button',
                        width: '100px',
                        id: 'btnUpload',
                        text: 'Sačuvaj',
                        align: 'right',
                        cls: 'field-margin',
                        iconCls: 'savedugme',
                        //columnWidth: 0.15,
                        handler: function () {

                            if(formPanel.isValid()) {

                                Ext.Ajax.request({
                                    url : uploadGradUrl,
                                    method : 'POST',
                                    params : {id: Ext.get('idgrad').dom.value
                                        ,naziv: Ext.getCmp('naziv').getValue()
                                        ,postanskibroj: Ext.getCmp('postanskibroj').getValue()
                                    },
                                    success: function(conn, response, options, eOpts) {
                                        // grid.getView().getStore().load();
                                        Ext.example.msg("Uspjeh", 'Uspješno sačuvano!');
                                        Ext.get('idgrad').dom.value = 0;
                                        Ext.getCmp('btnUpload').setText("Sačuvaj");
                                        storeGrid.load();
                                        formPanel.reset();
                                        //window.location.reload();
                                    },
                                    failure: function(conn, response, options, eOpts) {
                                        Ext.example.msg("GREŠKA!", 'Akcija nije izvršena');
                                        return false
                                    }

                                });
                            }
                        }
                    },
                    {
                        xtype: 'button',
                        width: '100px',
                        id: 'btnPonisti',
                        text: 'Poništi',
                        align: 'right',
                        iconCls: 'ponisti',
                        cls: 'field-margin',
                        //columnWidth: 0.15,
                        handler: function () {

                            Ext.getCmp('naziv').setValue("");
                            Ext.getCmp('postanskibroj').setValue("");
                            Ext.getCmp('btnUpload').setText('Sačuvaj');
                            Ext.get('idgrad').dom.value = 0;

                            storeGrid.load();
                        }
                    }
                ]
            });

            var grid = Ext.create('Ext.grid.Panel', {
                // width: 800,
                // height: 350,
                // cls: 'field-margin',
                //renderTo: Ext.getBody(),
                frame: true,
                title: 'Grad',
                store: storeGrid,
                stripeRows: false,
                iconCls: 'icon-user',
                columns: [{
                    text: 'Id',
                    flex: 1,
                    width: 50,
                    sortable: true,
                    dataIndex: 'id',
                    field: {
                        xtype: 'textfield'
                    }
                },{
                    text: 'Naziv',
                    flex: 1,
                    sortable: true,
                    dataIndex: 'naziv',
                    field: {
                        xtype: 'textfield'
                    }
                }, {
                    header: 'Poštanski broj',
                    flex: 1,
                    sortable: true,
                    dataIndex: 'postanskibroj',
                    field: {
                        xtype: 'textfield'
                    }
                },{
                    xtype : 'actioncolumn',
                    header : '',
                    width : 24,
                    align : 'top',
                    items : [
                        {
                            iconCls : 'gridizmjena',
                            tooltip : 'Izmjena podataka o gradu',
                            handler : function (grid, rowIndex, colIndex, item, e, record) {

                                var index =storeGrid.findExact('id', record.id);
                                var rec = storeGrid.getAt(index);

                                Ext.get('idgrad').dom.value = record.id;
                                Ext.getCmp('naziv').setValue(rec.get('naziv'));
                                Ext.getCmp('postanskibroj').setValue(rec.get('postanskibroj'));
                                Ext.getCmp('btnUpload').setText('Izmjena');
                            }
                        }
                    ]
                },{
                    xtype : 'actioncolumn',
                    header : '',
                    width : 24,
                    align : 'top',
                    items : [
                        {
                            iconCls : 'gridbrisanje',
                            tooltip : 'Brisanje fajl formata',
                            handler : function (grid, rowIndex, colIndex, item, e, record) {
                                //alert(record.id);

                                Ext.MessageBox.confirm('Potvrda', "Da li ste sigurni da želite da uklonite odabrani zapis?",function(btn, text) {
                                    if (btn == 'yes') {
                                        Ext.Ajax.request({
                                            url: izbrisiGradUrl,
                                            method: 'POST',
                                            params : {id: record.id
                                            },
                                            success: function(conn, response, options, eOpts) {
                                                Ext.example.msg("USPJEH", 'Akcija uspješno izvršena');
                                                storeGrid.load();
                                            },
                                            failure: function(conn, response, options, eOpts) {
                                                Ext.Msg.alert("GREŠKA!", 'Akcija nije izvršena');
                                                return false
                                            }
                                        });
                                    }
                                })
                            }
                        }
                    ]
                }
                ]
            });

            //formPanel.add(grid);
            viewPort.getComponent('northViewPortId').add(formPanel);
            viewPort.getComponent('southViewPortId').add(grid);

        });
    </script>
</head>
<body>
<input id="idgrad" type="hidden" value="11"/>
</body>
</html>