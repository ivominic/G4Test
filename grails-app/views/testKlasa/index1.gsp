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

        Ext.application({
            name: 'cdnjs test with charts package',

            launch: function() {
                Ext.create('Ext.panel.Panel', {
                    title: 'Hello',
                    width: 200,
                    html: '<p>World!</p>',
                    renderTo: Ext.getBody()
                });
                var formPanel = Ext.create('Ext.form.Panel', {
                    title: 'Measure unit',
                    bodyPadding: 10,
                    renderTo: Ext.getBody(),
                    items: [
                                {
                                    xtype: 'textfield',
                                    id: 'name',
                                    cls: 'field-margin',
                                    allowBlank : false,
                                    fieldLabel: 'Name',
                                    labelAlign: 'top',
                                    width: '300px'
                                },{
                                    xtype: 'textfield',
                                    id: 'description',
                                    cls: 'field-margin',
                                    allowBlank : false,
                                    fieldLabel: 'Description',
                                    labelAlign: 'top',
                                    width: '300px'
                                }
                            ,
                        {
                            xtype: 'button',
                            width: '100px',
                            id: 'btnSave',
                            text: 'Save',
                            align: 'right',
                            cls: 'field-margin',
                            margin: 10,
                            //iconCls: 'savedugme',
                            handler: function () {

                                if(formPanel.isValid()) {

                                    Ext.Ajax.request({
                                        url : zapisKreiranjeUrl,
                                        method : 'POST',
                                        params : {id: Ext.get('zapisid').dom.value
                                            ,name: Ext.getCmp('name').getValue()
                                            ,description: Ext.getCmp('description').getValue()
                                        },
                                        success: function(response, options) {
                                            var result = Ext.decode(response.responseText);
                                            if(result.success){
                                                Ext.example.msg("Success", result.message);
                                                Ext.get('zapisid').dom.value = 0;
                                                Ext.getCmp('btnSave').setText("Save");
                                                formPanel.reset();
                                                storeGrid.load();
                                            }else{
                                                Ext.Msg.alert("ERROR!", result.message);
                                            }
                                        },
                                        failure: function(response, options) {
                                            var result = Ext.decode(response.responseText);
                                            Ext.example.msg("ERROR!", result.message);
                                            return false
                                        }
                                    });
                                }
                            }
                        },{
                            xtype: 'button',
                            width: '100px',
                            id: 'btnCancel',
                            text: 'Cancel',
                            align: 'right',
                            //iconCls: 'ponisti',
                            margin: 10,
                            cls: 'field-margin',
                            handler: function () {

                                Ext.getCmp('name').setValue("");
                                Ext.getCmp('description').setValue("");
                                Ext.getCmp('btnSave').setText('Save');
                                Ext.get('zapisid').dom.value = 0;
                                storeGrid.load();
                            }
                        }
                    ]
                });

                Ext.create('Ext.chart.PolarChart', {
                    renderTo: document.body,
                    width: 500,
                    height: 500,
                    store: {
                        fields: ['name', 'g1', 'g2'],
                        data: [
                            {"name": "Item-0", "g1": 18.34,"g2": 0.04},
                            {"name": "Item-1", "g1": 2.67, "g2": 14.87},
                            {"name": "Item-2", "g1": 1.90, "g2": 5.72},
                            {"name": "Item-3", "g1": 21.37,"g2": 2.13},
                            {"name": "Item-4", "g1": 2.67, "g2": 8.53},
                            {"name": "Item-5", "g1": 18.22,"g2": 4.62}
                        ]
                    },

                    interactions: ['rotate'],

                    //configure the legend.
                    legend: {
                        docked: 'bottom'
                    },

                    //describe the actual pie series.
                    series: [{
                        type: 'pie',
                        xField: 'g1',
                        label: {
                            field: 'name',
                            display: 'rotate'
                        },
                        donut: 25,
                        style: {
                            miterLimit: 10,
                            lineCap: 'miter',
                            lineWidth: 2
                        }
                    }]
                });
            }
        });
    </script>
</head>
<body>
</body>
</html>